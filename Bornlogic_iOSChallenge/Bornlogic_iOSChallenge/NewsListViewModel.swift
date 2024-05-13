//
//  NewsListViewModel.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

protocol NewsViewModelDelegate: AnyObject {
    func newsDataDidUpdate()
    func newsDataDidFailWithError(_ error: NewsError)
}

class NewsListViewModel {
    weak var delegate: NewsViewModelDelegate?
    var newsData: [Article]?
    
    private let newsService: NewsServiceProtocol

    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }

    func loadNews() {
        Task {
            do {
                let data = try await newsService.fetchData()
                let filteredArticles = filterData(on: data, containing: "[Removed]")
                DispatchQueue.main.async { [weak self] in
                    self?.newsData = filteredArticles
                    self?.delegate?.newsDataDidUpdate()
                }
            } catch let error as NewsError {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.newsDataDidFailWithError(error)
                }
            }
        }
    }
    
    private func filterData(on data: NewsData?, containing expression: String) -> [Article]? {
        return data?.articles.filter { $0.title != expression }
    }
    
    // MARK: Table View Methods
    public var numberOfRowsInSection: Int {
        newsData?.count ?? 0
    }
    
    public func getCellForRow(on tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier,
                                                 for: indexPath) as? NewsListTableViewCell
        cell?.setupCellContent(with: newsData?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    public func heightForRowAt() -> CGFloat {
        400
    }
}

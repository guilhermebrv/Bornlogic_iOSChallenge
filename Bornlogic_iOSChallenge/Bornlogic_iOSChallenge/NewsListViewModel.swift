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

class NewsListViewModel: TableViewMethodsDelegate {
    weak var delegate: NewsViewModelDelegate?
    public var newsData: [Article]?
    private let newsService: NewsServiceDelegate

    init(newsService: NewsServiceDelegate) {
        self.newsService = newsService
    }

    // MARK: News Data Methods
    func loadNews() {
        Task {
            do {
                let data = try await newsService.fetchData(for: .topHeadlines, country: .unitedStates, category: .science)
                let filteredArticles = filterData(on: data, containingOnTitle: "[Removed]")
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
    
    public func filterData(on data: NewsData?, containingOnTitle expression: String) -> [Article]? {
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
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    public var heightForRowAt: CGFloat {
        405
    }
}

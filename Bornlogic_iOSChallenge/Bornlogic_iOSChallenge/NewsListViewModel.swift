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

class NewsListViewModel: ObservableObject {
    weak var delegate: NewsViewModelDelegate?
    var newsData: [Article]?
    var isLoading = false
    var error: NewsError?
    
    private let newsService: NewsServiceProtocol

    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }

    func loadNews() {
        isLoading = true
        Task {
            do {
                let data = try await newsService.fetchData()
                let filteredArticles = data?.articles.filter { $0.title != "[Removed]" }
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.newsData = filteredArticles
                    self.isLoading = false
                    self.delegate?.newsDataDidUpdate()
                }
            } catch let error as NewsError {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.error = error
                    self.isLoading = false
                    self.delegate?.newsDataDidFailWithError(error)
                }
            }
        }
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

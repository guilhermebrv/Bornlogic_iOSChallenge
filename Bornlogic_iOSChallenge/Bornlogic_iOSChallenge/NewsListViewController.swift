//
//  NewsListViewController.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListViewController: UIViewController {
    private var listView: NewsListView?
    private(set) var alert: UIAlertController?
    public var viewModel = NewsListViewModel(newsService: NewsService())
    static var firstTimeAccessingDetails = true
    
    override func loadView() {
        super.loadView()
        listView = NewsListView()
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listView?.spinner.startAnimating()
        signProtocols()
        viewModel.loadNews()
        firstMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configNavBar(title: Constants.MAIN_TITLE)
    }
}

extension NewsListViewController {
    private func signProtocols() {
        listView?.tableView.delegate = self
        listView?.tableView.dataSource = self
        viewModel.delegate = self
    }
}

extension NewsListViewController: NewsViewModelDelegate {
    func newsDataDidUpdate() {
        listView?.spinner.stopAnimating()
        listView?.tableView.reloadData()
    }
    
    func newsDataDidFailWithError(_ error: NewsError) {
        let errorHandler = ErrorHandler()
        let message = errorHandler.errorMessage(for: error)
        presentErrorAlert(message: message) {
            self.viewModel.loadNews()
        }
    }
    
    private func presentErrorAlert(message: String, retryHandler: @escaping () -> Void) {
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        guard let alert else { return }
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            retryHandler()
        }
        alert.addAction(retryAction)
        self.present(alert, animated: true)
    }
}

extension NewsListViewController: TableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getCellForRow(on: tableView, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.newsData?[indexPath.row] else { return }
        
        let detailsScreen = DetailsViewController(article: data, firstTimeAccessing: NewsListViewController.firstTimeAccessingDetails)
        navigationController?.pushViewController(detailsScreen, animated: true)
    }
}

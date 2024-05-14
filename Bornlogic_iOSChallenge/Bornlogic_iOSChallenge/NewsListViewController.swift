//
//  NewsListViewController.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListViewController: UIViewController {
    private var listView: NewsListView?
    private var viewModel = NewsListViewModel(newsService: NewsService())
    
    override func loadView() {
        super.loadView()
        listView = NewsListView()
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listView?.spinner.startAnimating()
        signProtocols()
//        setupRefreshControl()
        viewModel.loadNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavBar(title: Constants.MAIN_TITLE)
    }

}

extension NewsListViewController {
    private func signProtocols() {
        listView?.tableView.delegate = self
        listView?.tableView.dataSource = self
        viewModel.delegate = self
    }
    
//    private func setupRefreshControl() {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
//        listView?.tableView.refreshControl = refreshControl
//    }
//
//    @objc private func refreshNewsData(_ sender: UIRefreshControl) {
//        viewModel.loadNews()
//        sender.endRefreshing()
//    }
}

extension NewsListViewController: NewsViewModelDelegate {
    func newsDataDidUpdate() {
        listView?.spinner.stopAnimating()
        listView?.tableView.reloadData()
    }
    
    func newsDataDidFailWithError(_ error: NewsError) {
//        let message = errorMessage(for: error)
//        presentErrorAlert(message: message)
    }
    
//    private func errorMessage(for error: Error) -> String {
//        if let newsError = error as? NewsError {
//            switch newsError {
//            case .invalidURL(let urlString):
//                return "The URL \(urlString) is invalid."
//            case .invalidResponse:
//                return "The response from the server was invalid."
//            case .invalidData:
//                return "The data received was corrupt or unreadable."
//            }
//        } else {
//            return error.localizedDescription
//        }
//    }
//    
//    private func presentErrorAlert(message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        self.present(alert, animated: true, completion: nil)
//    }
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
        
        let detailsScreen = DetailsViewController(article: data)
        navigationController?.pushViewController(detailsScreen, animated: true)
    }
    
}


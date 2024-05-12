//
//  NewsListViewController.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListViewController: UIViewController {
    private var listView: NewsListView?
    private let viewModel = NewsListViewModel()
    
    override func loadView() {
        super.loadView()
        listView = NewsListView()
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavBar(title: Constants.mainTitle)
    }

}

extension NewsListViewController {
    private func signProtocols() {
        listView?.tableView.delegate = self
        listView?.tableView.dataSource = self
    }
}

extension NewsListViewController: NewsListViewDelegate {
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
    
    
}


//
//  DetailsViewController.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    private var articleData: Article
    private var detailsView: DetailsView?
    private var viewModel: DetailsViewModel?   
    private var firstTimeAccessing: Bool?
    
    init(article: Article, firstTimeAccessing: Bool) {
        self.articleData = article
        self.firstTimeAccessing = firstTimeAccessing
        self.viewModel = DetailsViewModel(article: articleData)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        detailsView = DetailsView()
        view = detailsView
        view.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
        navigationController?.navigationBar.prefersLargeTitles = false
        if firstTimeAccessing == true {
            finalMessages()
            NewsListViewController.firstTimeAccessingDetails = false
        }
    }
}

extension DetailsViewController {
    private func signProtocols() {
        detailsView?.tableView.delegate = self
        detailsView?.tableView.dataSource = self
    }
}

extension DetailsViewController: TableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel?.getCellForRow(on: tableView, at: indexPath) ?? UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.heightForRowAt ?? 600
    }
}

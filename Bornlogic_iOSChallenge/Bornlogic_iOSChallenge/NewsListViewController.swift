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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavBar(title: Constants.mainTitle)
    }

}


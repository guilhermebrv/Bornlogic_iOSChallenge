//
//  DetailsView.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

protocol DetailsViewDelegate: UITableViewDelegate, UITableViewDataSource {
}

class DetailsView: UIView {
    public let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createElements()
        addElements()
        configConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsView {
    private func createElements() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .secondarySystemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.register(NewsDetailsTableViewCell.self, forCellReuseIdentifier: NewsDetailsTableViewCell.identifier)
    }
    
    private func addElements() {
        addSubview(tableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

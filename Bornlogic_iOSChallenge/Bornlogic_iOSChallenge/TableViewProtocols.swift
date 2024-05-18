//
//  TableViewProtocols.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import UIKit

protocol TableViewMethodsDelegate {
    var numberOfRowsInSection: Int { get }
    var heightForRowAt: CGFloat { get }
    func getCellForRow(on tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

protocol TableViewDelegate: UITableViewDelegate, UITableViewDataSource {
}

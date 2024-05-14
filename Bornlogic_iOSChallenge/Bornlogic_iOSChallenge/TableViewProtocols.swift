//
//  TableViewProtocols.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import UIKit

protocol TableViewMethodsDelegate {
    var numberOfRowsInSection: Int { get }
    func getCellForRow(on tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    var heightForRowAt: CGFloat { get }
}

protocol TableViewDelegate: UITableViewDelegate, UITableViewDataSource {
}

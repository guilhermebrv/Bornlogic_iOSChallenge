//
//  NewsListViewModel.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListViewModel {
    // MARK: Table View Methods
    public var numberOfRowsInSection: Int {
        3
    }
    
    public func getCellForRow(on tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier,
                                                 for: indexPath) as? NewsListTableViewCell
        return cell ?? UITableViewCell()
    }
    
    public var heightForRowAt: CGFloat {
        450
    }
}

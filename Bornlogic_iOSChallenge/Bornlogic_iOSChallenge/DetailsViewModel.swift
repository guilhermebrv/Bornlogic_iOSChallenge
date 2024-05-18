//
//  DetailsViewModel.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

class DetailsViewModel: TableViewMethodsDelegate {
    private var articleData: Article?
    
    init(article: Article) {
        articleData = article
    }
    
    // MARK: Table View Methods
    public var numberOfRowsInSection: Int {
        1
    }
    
    public func getCellForRow(on tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailsTableViewCell.identifier,
                                                 for: indexPath) as? NewsDetailsTableViewCell
        cell?.setupCellContent(with: articleData)
        return cell ?? UITableViewCell()
    }
    
    public var heightForRowAt: CGFloat {
        600
    }
}

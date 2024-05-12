//
//  NewsListTableViewCell.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsListTableViewCell.self)
    let cellView = NewsListCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsListTableViewCell {
    public func setupCellContent() {
        
    }
    private func configScreen() {
        contentView.addSubview(cellView)
        cellView.pin(to: contentView)
    }
}

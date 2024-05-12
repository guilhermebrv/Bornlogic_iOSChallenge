//
//  NewsListCellView.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListCellView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createElements()
        addElements()
        configConstraints()
        backgroundColor = .purple
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsListCellView {
    private func createElements() {
    }
    
    private func addElements() {
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}

//
//  CellProtocols.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import UIKit

protocol CellDataDelegate: AnyObject {
    func setupCellContent(with article: Article?)
    func setupImages(from urlString: String)
}

protocol ConfigurableView {
    func configure(with data: Article?)
    func setImage(with image: UIImage)
}

//
//  NewsListTableViewCell.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsListTableViewCell.self)
    private var imageService: ImageService?
    private let cellView = NewsListCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configScreen()
        cellView.spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configScreen() {
        contentView.addSubview(cellView)
        cellView.pin(to: contentView)
    }
}

extension NewsListTableViewCell: CellDataDelegate {
    public func setupCellContent(with article: Article?) {
        cellView.configure(with: article)
        setupImages(from: article?.urlToImage ?? "")
    }
    
    public func setupImages(from urlString: String) {
        imageService = ImageService()
        
        Task {
            if let image = await imageService?.downloadImageAsync(from: urlString) {
                DispatchQueue.main.async {
                    self.cellView.setImage(with: image)
                    self.cellView.spinner.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.cellView.setImage(with: UIImage(systemName: "photo.on.rectangle.angled")!)
                    self.cellView.spinner.stopAnimating()
                }
            }
        }
    }
}

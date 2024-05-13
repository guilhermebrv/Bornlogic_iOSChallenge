//
//  NewsDetailsTableViewCell.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

class NewsDetailsTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsDetailsTableViewCell.self)
    private var imageDownloader: ImageDownloader?
    private let cellView = NewsDetailsCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configScreen() {
        contentView.addSubview(cellView)
        cellView.pin(to: contentView)
    }

}

extension NewsDetailsTableViewCell: CellDataDelegate {
    func setupCellContent(with article: Article?) {
        setupImages(from: article?.urlToImage ?? "")
        cellView.dateLabel.text = article?.publishedAt.description
        cellView.contentLabel.text = article?.content
    }
    
    func setupImages(from urlString: String) {
        imageDownloader = ImageDownloader()
        
        Task {
            if let image = await imageDownloader?.downloadImageAsync(from: urlString) {
                DispatchQueue.main.async {
                    self.cellView.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.cellView.imageView.contentMode = .scaleAspectFit
                    self.cellView.imageView.image = UIImage(systemName: "photo.on.rectangle.angled")?
                        .withTintColor(.secondarySystemBackground, renderingMode: .alwaysOriginal)
                }
            }
        }
    }
}

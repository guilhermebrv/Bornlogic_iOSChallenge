//
//  NewsListTableViewCell.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsListTableViewCell.self)
    private var imageDownloader: ImageDownloader?
    private let cellView = NewsListCellView()

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

extension NewsListTableViewCell {
    public func setupCellContent(with article: Article?) {
        setupImages(from: article?.urlToImage ?? "")
        cellView.titleLabel.text = article?.title
        cellView.authorLabel.text = article?.author
        cellView.descriptionLabel.text = article?.description
    }
    
    private func setupImages(from urlString: String) {
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

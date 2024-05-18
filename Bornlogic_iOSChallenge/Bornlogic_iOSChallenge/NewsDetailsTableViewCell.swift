//
//  NewsDetailsTableViewCell.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

class NewsDetailsTableViewCell: UITableViewCell {
    static let identifier = String(describing: NewsDetailsTableViewCell.self)
    private var imageService: ImageService?
    private let cellView = NewsDetailsCellView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellView.contentLabel.text = nil
        cellView.dateLabel.text = nil
        cellView.imageView.image = nil
    }

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
                }
            } else {
                DispatchQueue.main.async {
                    self.cellView.setImage(with: UIImage(systemName: "photo.on.rectangle.angled")!)
                }
            }
        }
    }
}

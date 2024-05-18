//
//  NewsDetailsCellView.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

class NewsDetailsCellView: UIView {
    let stackView = UIStackView()
    let imageView = UIImageView()
    let dateLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createElements()
        addElements()
        configConstraints()
        backgroundColor = .secondarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsDetailsCellView: ConfigurableView {
    func setImage(with image: UIImage) {
        if image == UIImage(systemName: "photo.on.rectangle.angled") {
            imageView.image = image
                .withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
            imageView.contentMode = .scaleAspectFit

        } else {
            imageView.image = image
        }
    }
    
    func configure(with data: Article?) {
        dateLabel.text = data?.publishedAt?.formatted()
        contentLabel.text = data?.content
    }
}


extension NewsDetailsCellView  {
    private func createElements() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(contentLabel)
    }
    
    private func addElements() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.textAlignment = .right
        dateLabel.textColor = .label
        dateLabel.numberOfLines = 1
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentLabel.textColor = .label
        contentLabel.textAlignment = .justified
        contentLabel.numberOfLines = 0
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

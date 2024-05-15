//
//  NewsListCellView.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

class NewsListCellView: UIView {
    let bgView = UIView()
    let stackView = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let authorLabel = UILabel()
    let spinner = UIActivityIndicatorView(style: .medium)
    
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

extension NewsListCellView: ConfigurableView {
    func setImage(with image: UIImage) {
        if image != UIImage(systemName: "photo.on.rectangle.angled") {
            imageView.image = image
        } else {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
                .withTintColor(.secondarySystemBackground, renderingMode: .alwaysOriginal)
        }
    }
    
    func configure(with data: Article?) {
        titleLabel.text = data?.title
        authorLabel.text = data?.author
        descriptionLabel.text = data?.description
    }
}

extension NewsListCellView {
    private func createElements() {
        addSubview(bgView)
        bgView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
        imageView.addSubview(spinner)
        bgView.addSubview(authorLabel)
    }
    
    private func addElements() {
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .tertiarySystemBackground
        bgView.layer.cornerRadius = 10
        bgView.layer.shadowColor = UIColor.label.cgColor
        bgView.layer.shadowOpacity = 0.3
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 3
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .justified
        titleLabel.numberOfLines = 2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
                
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 3
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        authorLabel.textColor = .label
        authorLabel.textAlignment = .right
        authorLabel.numberOfLines = 1
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            authorLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
            authorLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
}

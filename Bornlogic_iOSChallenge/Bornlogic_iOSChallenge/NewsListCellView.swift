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

extension NewsListCellView {
    private func createElements() {
        addSubview(bgView)
        bgView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
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
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .justified
        titleLabel.numberOfLines = 2
        titleLabel.text = "Elon Musk Says Billionaire Investor Warren Buffett Should Buy Tesla Stock. Here's Why He Absolutely, Positively Won't."
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 3
        descriptionLabel.text = "Title lorem ipsum dolor sit amet, consectetur adipiscing elit. More text here and I need to make this text bigger to see how it will look."
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        authorLabel.textColor = .label
        authorLabel.numberOfLines = 1
        authorLabel.text = "by Guilherme Viana"
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
        ])
    }
}

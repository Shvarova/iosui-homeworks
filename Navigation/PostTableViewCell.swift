//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Дина Шварова on 30.12.2022.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    private lazy var postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.left
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imagePost: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "System", size: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var statisticsView = UIView()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "System", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "System", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage (name: String, filter: ColorFilter) {
        guard let image = UIImage (named: name) else {
            print("No image")
            return
        }
 //       imagePost.image = image
 //       ImageProcessor().processImage(sourceImage: image, filter: .gaussianBlur(radius: 3), completion: (nil) -> Void)
        
        let processor = ImageProcessor()
        processor.processImage(sourceImage: image, filter: filter) { filteredImage in
                    imagePost.image = filteredImage
                }
    }
    
    private func setupView () {
        backgroundColor = .white
        postStackView.addArrangedSubview(descriptionLabel)
        postStackView.addArrangedSubview(statisticsView)
        statisticsView.addSubviews([likesLabel, viewsLabel])
        addSubviews([authorLabel, imagePost, postStackView])
        setupConstraints()
    }
    
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            imagePost.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imagePost.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            imagePost.leadingAnchor.constraint(equalTo: leadingAnchor),
            imagePost.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            postStackView.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 16),
            postStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            postStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: statisticsView.leadingAnchor),
            
            viewsLabel.topAnchor.constraint(equalTo: statisticsView.topAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: statisticsView.trailingAnchor)
        ])
    }
}

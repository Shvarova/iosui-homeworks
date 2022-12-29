//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дина Шварова on 27.09.2022.
//

import UIKit

class ProfileHeaderView: UIView {
      
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.text = "Hipster Cat"
        name.textAlignment = .left
        return name
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel ()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.text = statusText
        return status
    }()
    
    private let userAvatar: UIImageView = {
        let avatar = UIImageView ()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.image = UIImage(named: "Photo")
        avatar.layer.cornerRadius = 60
        avatar.layer.borderWidth = 3
        avatar.layer.masksToBounds = true
        avatar.layer.borderColor = UIColor.white.cgColor
        return avatar
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(statusTextChanged), for: .touchUpInside)
        return button
    } ()
    
    let statusTextField: UITextField = {
       let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.backgroundColor = .white
        text.layer.cornerRadius = 12
        text.layer.masksToBounds = true
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        return text
    }()
    
    private var statusText: String = "Waiting for something..."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.backgroundColor = .lightGray
        
        self.addSubview(userAvatar)
        self.addSubview(nameLabel)
        self.addSubview(statusButton)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        
        NSLayoutConstraint.activate([
            userAvatar.widthAnchor.constraint(equalToConstant: 120),
            userAvatar.heightAnchor.constraint(equalToConstant: 120),
            userAvatar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 16),
            userAvatar.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor,constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -16),
            
            statusButton.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint (equalTo: trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint (equalToConstant: 50),
            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 12),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            statusLabel.centerYAnchor.constraint(equalTo: userAvatar.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -16),
            
            statusTextField.widthAnchor.constraint(equalToConstant: 200),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 12),
            statusTextField.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
        
    }

    @objc func statusTextChanged() {
        print(statusLabel.text as Any)
        self.statusLabel.text = self.statusTextField.text
        if self.statusLabel.text == "" {
            self.statusLabel.text = self.statusText
        }
    }
}

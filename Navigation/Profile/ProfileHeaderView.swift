//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дина Шварова on 27.09.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func tapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView {

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Photo"))
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.text = "Waiting with something..."
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.tapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Waiting with something..."
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .systemGray2
        textField.backgroundColor = .systemGray4
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.keyboardType = .default
        textField.clearButtonMode = .always
        textField.alpha = 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private var showStatusButtonConstraintOn: NSLayoutConstraint?
    private var showStatusButtonConstraintOff: NSLayoutConstraint?
    weak var delegate: ProfileHeaderViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {
        self.addSubview(self.photoImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.statusTextView)
        self.addSubview(self.showStatusButton)
        self.addSubview(self.statusTextView)
        self.addSubview(self.statusTextField)
        let topPhotoImageConstraint = self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingPhotoImageConstraint = self.photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let widthPhotoImageConstraint = self.photoImageView.widthAnchor.constraint(equalToConstant: 150)
        let heightPhotoImageConstraint = self.photoImageView.heightAnchor.constraint(equalToConstant: 150)
        let topNameLabelConstraint = self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leadingNameLabelConstraint = self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 182)
        let trailingNameLabelConstraint = self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        self.showStatusButtonConstraintOn = self.showStatusButton.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: 16)
        self.showStatusButtonConstraintOn?.priority = UILayoutPriority(rawValue: 999)
        let leadingShowStatusButton = self.showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingShowStatusButton = self.showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightShowStatusButton = self.showStatusButton.heightAnchor.constraint(equalToConstant: 50)
        let bottomStatusTextView = self.statusTextView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -18)
        let leadingStatusTextView = self.statusTextView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        let trailingStatusTextView = self.statusTextView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        let heightStatusTextView = self.statusTextView.heightAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([
            topPhotoImageConstraint, leadingPhotoImageConstraint, widthPhotoImageConstraint,
            heightPhotoImageConstraint, topNameLabelConstraint, leadingNameLabelConstraint,
            trailingNameLabelConstraint,
            self.showStatusButtonConstraintOn, leadingShowStatusButton, trailingShowStatusButton,
            heightShowStatusButton, bottomStatusTextView, leadingStatusTextView,
            trailingStatusTextView, heightStatusTextView
        ].compactMap({ $0}))
    }

    @objc func tap(_ sender: Any) {
        statusTextField.resignFirstResponder()
    }

    @objc private func tapStatusButton() {
        if self.statusTextField.isHidden {
            self.statusTextField.alpha = 1
            NSLayoutConstraint.deactivate([self.showStatusButtonConstraintOff].compactMap({ $0 }))
            let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.statusTextView.bottomAnchor, constant: 27)
            let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusTextView.leadingAnchor)
            let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.statusTextView.trailingAnchor)
            let heightStatusTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 34)
            self.showStatusButtonConstraintOn = self.showStatusButton.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: 70)
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightStatusTextFieldConstraint,
                self.showStatusButtonConstraintOn
            ].compactMap({ $0 }))
        } else {
            self.statusTextField.isHidden = false
            self.statusTextField.alpha = 0
            NSLayoutConstraint.deactivate([self.showStatusButtonConstraintOn].compactMap({ $0 }))
            if self.statusTextField.text != "" {
                self.statusTextView.text = self.statusTextField.text
                self.statusTextField.text = .none
            }
            self.showStatusButtonConstraintOff = self.showStatusButton.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: 16)

            NSLayoutConstraint.activate([self.showStatusButtonConstraintOff].compactMap({ $0 }))
            self.endEditing(true)
        }
        self.delegate?.tapStatusButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
}


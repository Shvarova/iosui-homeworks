//
//  CustomButton.swift
//  Navigation
//
//  Created by Дина Шварова on 08.02.2023.
//

import UIKit

class CustomButton: UIButton {
    
    var action: (() -> ())?
    
    init(title: String, titleColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        setupButton(title: title, titleColor: titleColor, cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton (title: String, titleColor: UIColor, cornerRadius: CGFloat) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        action? ()
    }
}

//
//  StackView.swift
//  Navigation
//
//  Created by Дина Шварова on 22.03.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView ...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

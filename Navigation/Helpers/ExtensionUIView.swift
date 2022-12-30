//
//  ExtensionUIView.swift
//  Navigation
//
//  Created by Дина Шварова on 29.12.2022.
//

import UIKit

extension UIView {
    func addSubviews (_ subViews: [UIView]) {
        subViews.forEach { view in
            addSubview(view)
        }
    }
}

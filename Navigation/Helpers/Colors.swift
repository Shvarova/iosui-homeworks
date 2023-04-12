//
//  Colors.swift
//  Navigation
//
//  Created by Дина Шварова on 12.04.2023.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }
}

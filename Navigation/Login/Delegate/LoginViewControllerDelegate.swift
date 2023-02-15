//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Дина Шварова on 29.01.2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check (login: String, password: String) -> Bool
}

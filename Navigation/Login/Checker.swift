//
//  Checker.swift
//  Navigation
//
//  Created by Дина Шварова on 29.01.2023.
//

import UIKit


class Checker: LoginViewControllerDelegate {
    
    static let shared = Checker()
    
    private let currentLogin = "Java_cat"
    private let currentPassword = "132435"

    private init() {}

    func check (login: String, password: String) -> Bool {
        return login == currentLogin && password == currentPassword ? true : false
    }
}


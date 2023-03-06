//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дина Шварова on 29.01.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check (login: String, password: String) throws {
        let checker = Checker.shared
        try checker.check (login: login, password: password)
    }
}

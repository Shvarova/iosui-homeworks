//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дина Шварова on 29.01.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check (login: String, password: String) -> Bool {
        let checker = Checker.shared
        return checker.check (login: login, password: password)
    }
}

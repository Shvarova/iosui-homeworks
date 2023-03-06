//
//  Checker.swift
//  Navigation
//
//  Created by Дина Шварова on 29.01.2023.
//

import UIKit

enum CustomError: Error {
    case invalidUser
    case network 
}

class Checker: LoginViewControllerDelegate {
    
    static let shared = Checker()
    
    private let currentLogin = "admin"
    private let currentPassword = "admin"

    private init() {}

    func check (login: String, password: String) throws {
        if login != currentLogin || password != currentPassword {
            throw CustomError.invalidUser
        }
        
    }
}


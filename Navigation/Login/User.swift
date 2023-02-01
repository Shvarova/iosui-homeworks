//
//  User.swift
//  Navigation
//
//  Created by Дина Шварова on 28.01.2023.
//

import UIKit

protocol UserService {
    func checkLogin (login : String) -> User?
    func getUser () -> User
}

class User {
    let login : String
    let name : String
    let avatar : UIImage
    let status : String

    init(login: String, name: String, avatar: UIImage, status: String) {
        self.login = login
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}

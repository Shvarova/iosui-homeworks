//
//  User.swift
//  Navigation
//
//  Created by Дина Шварова on 28.01.2023.
//

import UIKit

protocol UserService {
    func getUser () -> User
}

class User {
    let name : String
    let avatar : UIImage
    let status : String

    init(name: String, avatar: UIImage, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}

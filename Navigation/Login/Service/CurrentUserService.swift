//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Дина Шварова on 28.01.2023.
//

import UIKit

class CurrentUserService: UserService {
    
    private var newUser: User = User(name: "Java cat", avatar: UIImage(named: "avatar") ?? UIImage() ,status: "Делаю домашку")
     
    func getUser () -> User {
        return newUser
    }
}

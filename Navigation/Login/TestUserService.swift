//
//  TestUserService.swift
//  Navigation
//
//  Created by Дина Шварова on 28.01.2023.
//

import UIKit

class TestUserService: UserService {
    
    private var testUser: User = User(name: "Test", avatar: UIImage(named: "test") ?? UIImage() ,status: "Тестовый аккаунт")
     
    func getUser () -> User {
        return testUser
    }
}

//
//  TestUserService.swift
//  Navigation
//
//  Created by Дина Шварова on 28.01.2023.
//

import UIKit

class TestUserService: UserService {
    
    private var testUser: User = User(login: "Test", name: "Test", avatar: UIImage(named: "test") ?? UIImage() ,status: "Тестовый аккаунт")
     
    func checkLogin(login: String) -> User? {
        return testUser.login == login ? testUser : nil
    }
}

//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Дина Шварова on 29.01.2023.
//

import Foundation

struct MyLoginFactory: Loginfactory {
    static func makeLoginInspector() -> LoginInspector {
       return LoginInspector()
    }
}

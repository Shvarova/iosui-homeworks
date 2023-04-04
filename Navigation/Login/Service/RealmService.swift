//
//  RealmService.swift
//  Navigation
//
//  Created by Дина Шварова on 31.03.2023.
//

import Foundation
import RealmSwift

class LoginObject: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    @objc dynamic var authorized = false
}

class RealmService {
    static let shared = RealmService()
    private let realm = try! Realm()
    
    private init () {}
    
    func write (login: String, password: String) {
        let model = LoginObject()
        model.login = login
        model.password = password
        model.authorized = true
        try! realm.write({
            realm.add(model)
        })
    }
    
    func isUserAuthorized() -> Bool {
        guard let result = realm.objects(LoginObject.self).first else { return false }
        return result.authorized
    }
    
    func remove() {
            do {
                let result = realm.objects(LoginObject.self)
                realm.beginWrite()
                realm.delete(result)
                try realm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        }
}

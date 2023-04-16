//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Дина Шварова on 15.04.2023.
//

import UIKit
import LocalAuthentication

class LocalAuthorizationService {
    
    static let shared = LocalAuthorizationService()
    private init () {}
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            authorizationFinished (false)
            return
        }
        
        let reason = "Вход через биометрические данные"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
           success, authenticationError in
            
            DispatchQueue.main.async {
                if success {
                    authorizationFinished (true)
                } else {
                    authorizationFinished (false)
                }
            }
        }
    }
}

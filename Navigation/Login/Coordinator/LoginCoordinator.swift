//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 17.02.2023.
//

import UIKit

final class LoginCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller: UIViewController
    private let loginVC = LoginViewController()
    private let loginNC: UINavigationController
    
    init() {
       
        let loginInspector = MyLoginFactory.makeLoginInspector()
        loginVC.loginDelegate = loginInspector
        loginNC = UINavigationController(rootViewController: loginVC)
        loginNC.tabBarItem = UITabBarItem(title: "Профиль",
                                            image: UIImage(systemName: "person.crop.circle"),
                                            selectedImage: UIImage(systemName: "person.crop.circle"))
        controller = loginNC
    }
    
    func start() {
        loginVC.output = self
    }
    
    func getViewController() -> UIViewController {
        controller
    }
    
    fileprivate func showProfileViewController() {
            let profileCoordinator = ProfileCoordinator(navigationController: loginNC)
            profileCoordinator.start()
            childs.append(profileCoordinator)
        }
}

extension LoginCoordinator: LoginOutput {
    func loginButtonTouched() {
        showProfileViewController()
    }
}

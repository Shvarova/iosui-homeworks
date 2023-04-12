//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 17.02.2023.
//

import UIKit

final class LoginCoordinator: TapBarCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller: UINavigationController
    private let loginVC = LoginViewController()
    private let loginNC: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
       
        let loginInspector = MyLoginFactory.makeLoginInspector()
        loginVC.loginDelegate = loginInspector
        self.loginNC = navigationController
        loginNC.setViewControllers([loginVC], animated: true)
        loginNC.tabBarItem = UITabBarItem(title: NSLocalizedString("Profile", comment: ""),
                                            image: UIImage(systemName: "person.crop.circle"),
                                            selectedImage: UIImage(systemName: "person.crop.circle"))
        controller = loginNC
        loginVC.output = self
        loginNC.navigationBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
    }
    
    func start() {
    }
    
    func getNavigationController() -> UINavigationController {
        controller
    }
    
    func getViewController() -> UIViewController {
        loginVC
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

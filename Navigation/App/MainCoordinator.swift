//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 17.02.2023.
//

import UIKit

final class MainCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    
    private let navigationController: UINavigationController
    private let controller: UIViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let loginCoordinator = LoginCoordinator()
        let feedCoordinator = FeedCoordinator()
        
        childs = [loginCoordinator, feedCoordinator]
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = [feedCoordinator.getViewController(), loginCoordinator.getViewController()]
        controller = tabBarController
    }
    
    func start() {
        for child in childs {
            child.start()
        }
        navigationController.pushViewController(controller, animated: true)
    }
}

//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 17.02.2023.
//

import UIKit

protocol TapBarCoordinator: AppCoordinator {
    func getNavigationController () -> UINavigationController
}

final class MainCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    
    private let navigationController: UINavigationController
    private let controller: UIViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let loginCoordinator: TapBarCoordinator = RealmService.shared.isUserAuthorized() ? ProfileCoordinator() : LoginCoordinator()
        let feedCoordinator = FeedCoordinator()
        
        childs = [loginCoordinator, feedCoordinator]
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = [feedCoordinator.getNavigationController(), loginCoordinator.getNavigationController()]
        controller = tabBarController
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: true)
    }
}

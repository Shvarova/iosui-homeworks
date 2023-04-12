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
        let likedCoordinator = LikedCoordinator()
        let mapCoordinator = MapCoordinator()
        
        childs = [loginCoordinator, feedCoordinator, likedCoordinator]
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
        tabBarController.viewControllers = [feedCoordinator.getNavigationController(), mapCoordinator.getNavigationController(), likedCoordinator.getNavigationController(), loginCoordinator.getNavigationController()]
        controller = tabBarController
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: true)
    }
}

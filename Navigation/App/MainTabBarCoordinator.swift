//
//  MainTabBarCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class MainTabBarCoordinator: AppCoordinator {
    
    var loginOutput: LogInOutput?
    var feedOutput: FeedOutput?
    
    var childs: [AppCoordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.loginOutput = loginOutput
        mainTabBarController.feedOutput = feedOutput
        
        mainTabBarController.setupControllers()
        navigationController.pushViewController(mainTabBarController, animated: true)
    }
}

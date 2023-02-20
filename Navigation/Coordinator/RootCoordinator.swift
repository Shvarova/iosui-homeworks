//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class RootCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainTabBarController()
    }
    
    private func showMainTabBarController() {
        let tabBar = MainCoordinator(navigationController: navigationController)
        tabBar.start()
        childs.append(tabBar)
    }
}

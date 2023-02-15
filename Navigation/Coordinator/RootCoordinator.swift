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
        let tabBar = MainTabBarCoordinator(navigationController: navigationController)
        tabBar.loginOutput = self
        tabBar.feedOutput = self
        tabBar.start()
        childs.append(tabBar)
    }
    
    fileprivate func showProfileViewController() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.start()
        childs.append(profileCoordinator)
    }

    fileprivate func showNewPostViewController() {
        let coordinator = NewPostCoordinator(navigationController: navigationController)
        coordinator.output = self
        coordinator.start()
        childs.append(coordinator)
    }
    
    fileprivate func showInfoViewController() {
            let coordinator = InfoCoordinator(navigationController: navigationController)
            coordinator.start()
            childs.append(coordinator)
        }
}

extension RootCoordinator: LogInOutput {
    func loginButtonTouched() {
        showProfileViewController()
    }
}

extension RootCoordinator: FeedOutput {
    func postButtonTouched() {
        showNewPostViewController()
    }
}

extension RootCoordinator: NewPostOutput {
    func buttonInfoClicked() {
        showInfoViewController()
    }
}

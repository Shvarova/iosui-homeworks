//
//  NewPostCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class NewPostCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller = NewPostViewController()
    private let navigationController: UINavigationController
    var output: NewPostOutput?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        controller.output = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    fileprivate func showInfoViewController() {
        let coordinator = InfoCoordinator(navigationController: navigationController)
        coordinator.start()
        childs.append(coordinator)
    }
}

extension NewPostCoordinator: NewPostOutput {
    func buttonInfoClicked() {
        showInfoViewController()
    }
}

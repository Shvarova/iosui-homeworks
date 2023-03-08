//
//  NewPostCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 08.03.2023.
//

import UIKit

protocol NewPostOutput {
    func buttonInfoClicked()
}

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


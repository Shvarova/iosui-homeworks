//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class NewPostCoordinator: AppCoordinator {
    var childs: [AppCoordinator] = []
    var output: NewPostOutput?

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(getPostViewController(), animated: true)
    }

    private func getPostViewController() -> UIViewController {
        let vc = NewPostViewController()
        vc.output = output
        return vc
    }
}


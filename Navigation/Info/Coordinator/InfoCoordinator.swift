//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class InfoCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller = InfoViewController()
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(controller, animated: true)
    }
}

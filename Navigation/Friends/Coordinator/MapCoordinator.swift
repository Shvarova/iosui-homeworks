//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 06.04.2023.
//

import UIKit

final class MapCoordinator: AppCoordinator {

    var childs: [AppCoordinator] = []
    private let viewController = MapViewController()
    private let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: "Друзья",
                                            image: UIImage(systemName: "map.circle"),
                                            selectedImage: UIImage(systemName: "map.circle"))
    }

    func getNavigationController() -> UIViewController {
        navigationController
    }
}

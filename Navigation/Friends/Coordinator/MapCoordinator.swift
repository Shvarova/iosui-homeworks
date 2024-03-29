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
        navigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Friends", comment: ""),
                                            image: UIImage(systemName: "map.circle"),
                                            selectedImage: UIImage(systemName: "map.circle"))
        navigationController.navigationBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
    }

    func getNavigationController() -> UIViewController {
        navigationController
    }
}

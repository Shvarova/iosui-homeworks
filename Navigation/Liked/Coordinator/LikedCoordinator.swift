//
//  LikedCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 04.04.2023.
//

import UIKit

final class LikedCoordinator: AppCoordinator {

    var childs: [AppCoordinator] = []
    private let viewController = LikedViewController()
    private let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Liked", comment: ""),
                                            image: UIImage(systemName: "heart"),
                                            selectedImage: UIImage(systemName: "heart.fill"))
    }

    func getNavigationController() -> UIViewController {
        navigationController
    }
}

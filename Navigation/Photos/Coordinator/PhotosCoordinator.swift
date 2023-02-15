//
//  PhotosCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class PhotosCoordinator: AppCoordinator {
    var childs: [AppCoordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(getPhotosViewController(), animated: true)
    }

    private func getPhotosViewController() -> UIViewController {
        let vc = PhotosViewController()
        return vc
    }
}

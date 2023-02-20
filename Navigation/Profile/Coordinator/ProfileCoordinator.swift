//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class ProfileCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller = ProfileViewController()
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        setProfileViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func setProfileViewController() {
        controller.output = self
        let viewModel = ProfileViewModel()
        controller.setViewModel(viewModel: viewModel)
    }
    
    fileprivate func showPhotosViewController() {
            let coordinator = PhotosCoordinator(navigationController: navigationController)
            coordinator.start()
            childs.append(coordinator)
        }
}

extension ProfileCoordinator: ProfileOutput {
    func photosCellSelected() {
        showPhotosViewController()
    }
}

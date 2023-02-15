//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class ProfileCoordinator: AppCoordinator {
    var childs: [AppCoordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(getProfileViewController(), animated: true)
    }

    private func getProfileViewController() -> UIViewController {
        let vc = ProfileViewController()
        let viewModel = ProfileViewModel()
        vc.setViewModel(viewModel: viewModel)
        return vc
    }
}

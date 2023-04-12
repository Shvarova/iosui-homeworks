//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

final class ProfileCoordinator: TapBarCoordinator {

    var childs: [AppCoordinator] = []
    private let controller = ProfileViewController()
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        setProfileViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
    func getNavigationController() -> UINavigationController {
        navigationController = UINavigationController(rootViewController: controller)
                navigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Profile", comment: ""),
                                                  image: UIImage(systemName: "person.crop.circle"),
                                                  selectedImage: UIImage(systemName: "person.crop.circle"))
                setProfileViewController()
        navigationController.navigationBar.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
                return navigationController
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
    fileprivate func signOut() {
        
        RealmService.shared.remove()
        if navigationController.viewControllers.count == 2 {
            navigationController.popViewController(animated: true)
            return
        }
        let lc = LoginCoordinator(navigationController: navigationController)
        let controller = lc.getViewController()
        navigationController.setViewControllers([controller], animated: true)
    }
}

extension ProfileCoordinator: ProfileOutput {
    func signOutButtonTouched() {
        signOut()
    }
    
    func photosCellSelected() {
        showPhotosViewController()
    }
}

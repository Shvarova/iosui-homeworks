//
//  AudioPostCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit

protocol AudioPostOutput {
    func buttonInfoClicked()
}

final class AudioPostCoordinator: AppCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller = AudioPostViewController()
    private let navigationController: UINavigationController
    var output: AudioPostOutput?
    
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

extension AudioPostCoordinator: AudioPostOutput {
    func buttonInfoClicked() {
        showInfoViewController()
    }
}

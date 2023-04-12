//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 17.02.2023.
//

import UIKit

import UIKit

final class FeedCoordinator: TapBarCoordinator {
    
    var childs: [AppCoordinator] = []
    private let controller: UINavigationController
    private let feedVC = FeedViewController()
    private let feedNC: UINavigationController
    
    init() {
        
        feedNC = UINavigationController(rootViewController: feedVC)
        feedNC.tabBarItem = UITabBarItem(title: NSLocalizedString("Newsline", comment: ""),
                                            image: UIImage(systemName: "newspaper"),
                                            selectedImage: UIImage(systemName: "newspaper"))
        controller = feedNC
        feedVC.output = self
    }
    
    func start() {
    }
    
    func getNavigationController() -> UINavigationController {
        controller
    }
    
    fileprivate func showNewPostViewController() {
        let coordinator = NewPostCoordinator(navigationController: feedNC)
        coordinator.start()
        childs.append(coordinator)
    }
    
    fileprivate func showAudioPostViewController() {
        let coordinator = AudioPostCoordinator(navigationController: feedNC)
        coordinator.start()
        childs.append(coordinator)
        }
}

extension FeedCoordinator: FeedOutput {
    func newPostButtonTouched() {
        showNewPostViewController()
    }

    func audioPostButtonTouched() {
        showAudioPostViewController()
    }
}

//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupControllers()
//    }
    
    var loginOutput: LogInOutput?
    var feedOutput: FeedOutput?
    
    func setupControllers() {
        
        let feedViewController = FeedViewController()
        feedViewController.output = feedOutput
        
        let loginViewController = LogInViewController()
        loginViewController.output = loginOutput
        loginViewController.loginDelegate = MyLoginFactory.makeLoginInspector()
        
        let feedNavigationController = createController(viewController: feedViewController, itemName: "Новости", ItemImage: "newspaper")
        let loginNavigationController = createController(viewController: loginViewController, itemName: "Авторизация", ItemImage: "person.circle")
        viewControllers = [feedNavigationController, loginNavigationController]
    }
        
    func createController(viewController: UIViewController, itemName: String, ItemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: ItemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0))  ,tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        return navigationController
    }
}


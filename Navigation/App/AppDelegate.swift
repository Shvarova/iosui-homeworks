//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дина Шварова on 25.09.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator.start()
        var config = AppConfiguration.people
        let random = Int.random(in: 0 ... 2)
        switch random {
        case 0: config = AppConfiguration.starships
        case 1: config = AppConfiguration.planets
        default: break
        }
        NetworkService.request(configurations: config)
        LocalNotificationsService.shared.registeForLatestUpdatesIfPossible()
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        try? Auth.auth().signOut()
    }
}


//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import Foundation

protocol AppCoordinator: AnyObject {
    var childs: [AppCoordinator] { get set }
}

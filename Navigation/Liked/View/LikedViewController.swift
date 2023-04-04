//
//  LikedViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 04.04.2023.
//

import UIKit

class LikedViewController: UIViewController {
    private let mainView = LikedView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.setPosts(posts: CoreDataService.shared.postEntities)
    }
}

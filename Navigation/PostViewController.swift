//
//  PostViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        let newPost = Post()
        let titleLabel = UILabel()
        titleLabel.text = newPost.title
        title = titleLabel.text
        navigationItem.backButtonTitle = "Назад"
        let infoImage = UIImage(named: "info")
        let infoButton = UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(buttonInfoClicked))
        navigationItem.rightBarButtonItem = infoButton
    }
        
    @objc func buttonInfoClicked() {
        let infoViewController = InfoViewController()
        navigationController?.pushViewController(infoViewController, animated: true)
    }
}

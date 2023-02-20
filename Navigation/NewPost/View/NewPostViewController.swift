//
//  NewPostViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

protocol NewPostOutput {
    func buttonInfoClicked()
}

class NewPostViewController: UIViewController {
    
    var output: NewPostOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = "Новый пост"
        title = titleLabel.text
        navigationItem.backButtonTitle = "Назад"
        let infoImage = UIImage(named: "info")
        let infoButton = UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(buttonInfoClicked))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func buttonInfoClicked() {
        output?.buttonInfoClicked()
    }
}

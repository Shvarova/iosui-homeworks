//
//  NewPostViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 08.03.2023.
//

import UIKit

class NewPostViewController: UIViewController {
    
    var output: NewPostOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
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

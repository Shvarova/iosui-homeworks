//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
            super.viewDidLoad()
            title = "Профиль"
        }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderViewSetup()
    }
    
    private func profileHeaderViewSetup() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .white
        self.view.addSubview(self.profileHeaderView)
        NSLayoutConstraint.activate([
            profileHeaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            profileHeaderView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func hideKeyboard() {
        profileHeaderView.statusTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}




//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let networkService = TodoNetworkService()
 
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 130, y: 770, width: 150, height: 40))
        button.setTitle("Уведомление", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(alertClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "Инфо"
        setupView()
        networkService.fetch { result in
            switch result {
            case .success(let title):
                DispatchQueue.main.async {
                    self.label.text = title
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
        networkService.fetchOrbitalPeriod { result in
            switch result {
            case .success(let orbitalPeriod):
                DispatchQueue.main.async {
                    self.orbitalPeriodLabel.text = orbitalPeriod
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func setupView() {
        view.addSubviews([button, label, orbitalPeriodLabel])
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24)
        ])
    }
    
    @objc func alertClicked() {
        let alert = UIAlertController(title: "Заголовок", message: "Текст уведомления", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Да", style: .default, handler: nil)
        let noButton = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
        print("Уведомление отправлено")
    }
}

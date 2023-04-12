//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

protocol FeedOutput: AnyObject {
    func newPostButtonTouched()
    func audioPostButtonTouched()
}

class FeedViewController: UIViewController {
    
    private var timer: Timer?
    
    var output: FeedOutput?
    private let feedModel = FeedModel ()
    
    private lazy var button1: UIButton = {
        let button = UIButton ()
        button.setTitle("5 хитов Queen", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(audioButtonClicked), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton ()
        button.setTitle("Новый пост 2", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newPostButtonClicked), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    } ()
    
    private lazy var textField: UITextField = {
        let textField = UITextField ()
        textField.font = .systemFont(ofSize: 16)
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton (title: NSLocalizedString("Check" , comment: ""), titleColor: .black, cornerRadius: 4)
        button.backgroundColor = .lightGray
        button.action = checkGuess
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView ()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .createColor(lightMode: .white, darkMode: .black)
        title = NSLocalizedString("Newsline", comment: "")
        setupView()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            let alert = UIAlertController(title: "Хотите получать подборку самых интересных новостей?", message: "будем ежедневно присылать на почту указанную при регистрации", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Да, спасибо", style: .default)
            let cancelAction = UIAlertAction(title: "Нет, не хочу", style: .destructive)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func setupView () {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        view.addSubviews([stackView, textField, checkGuessButton])
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func checkGuess () {
        guard let text = textField.text else {return}
        if feedModel.check(word: text) {
            checkGuessButton.backgroundColor = .green
        } else {
            checkGuessButton.backgroundColor = .red
        }
    }
    
    @objc func audioButtonClicked() {
        output?.audioPostButtonTouched()
    }
    
    @objc func newPostButtonClicked() {
        output?.newPostButtonTouched()
    }
}



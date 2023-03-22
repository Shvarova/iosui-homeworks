//
//  LoginViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 29.12.2022.
//

import UIKit
import FirebaseAuth

protocol LoginOutput: AnyObject {
    func loginButtonTouched()
}

class LoginViewController: UIViewController {
    
    var output: LoginOutput?
    var loginDelegate: LoginViewControllerDelegate?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.text = "admin@mail.ru"
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.placeholder = "Email or phone"
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = "admin123"
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.placeholder = "Password"
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton (title: "Log In", titleColor: .white, cornerRadius: 10)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.action = login
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signupButton: CustomButton = {
        let button = CustomButton (title: "Sign up", titleColor: .white, cornerRadius: 10)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.action = register
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bruteForceButton: CustomButton = {
        let button = CustomButton (title: "Brute Force", titleColor: .white, cornerRadius: 10)
        button.backgroundColor = .red
        button.action = getPassword
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubviews(logInButton, signupButton, bruteForceButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func login() {
        
        guard let login = loginTextField.text, !login.isEmpty else {
            showAlert(title: "Что-то пошло не так", message: "Поля 'логин' и 'пароль' не могут быть пустыми")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Что-то пошло не так", message: "Поля 'логин' и 'пароль' не могут быть пустыми")
            return
        }
        
        guard login.isValidEmail() else {
            showAlert(title: "Что-то пошло не так", message: "Введите корректный email")
            return
        }
        loginDelegate?.checkCredentials (withEmail: login, password: password) { result, error in
            if let error = error {
                self.showAlert(title: "Что-то пошло не так", message: error.localizedDescription)
            }
            if let _ = result {
                self.goToProfile()
            }
        }
    }
    
    @objc private func register () {
        guard let login = loginTextField.text, !login.isEmpty else {
            showAlert(title: "Что-то пошло не так", message: "Поля 'логин' и 'пароль' не могут быть пустыми")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Что-то пошло не так", message: "Поля 'логин' и 'пароль' не могут быть пустыми")
            return
        }
        
        guard login.isValidEmail() else {
            showAlert(title: "Что-то пошло не так", message: "Введите корректный email")
            return
        }
        
        loginDelegate?.signUp (withEmail: login, password: password) { result, error in
            if let error = error {
                self.showAlert(title: "Что-то пошло не так", message: error.localizedDescription)
            }
            
            if let _ = result {
                self.goToProfile()
            }
        }
    }
    
    private func goToProfile() {
        output?.loginButtonTouched()
    }
    
    private func getPassword() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomPassword = String((0 ..< 5).map{ _ in letters.randomElement()!})
            let possibleCharacters = letters.map { String($0) }
            var password = ""
            
            while password != randomPassword {
                password = BrutForce.generatePassword(password, fromArray: possibleCharacters)
            }
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.passwordTextField.text = password
                self.passwordTextField.isSecureTextEntry = false
            }
        }
    }
    
    private func showAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction (title: "ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginPasswordStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            loginPasswordStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginPasswordStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100),
            
            buttonsStackView.topAnchor.constraint(equalTo: loginPasswordStackView.bottomAnchor, constant: 16),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            bruteForceButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        loginPasswordStackView.addArrangedSubview(loginTextField)
        loginPasswordStackView.addArrangedSubview(passwordTextField)
        contentView.addSubviews([logoImageView, loginPasswordStackView, buttonsStackView, activityIndicator])
    }
}


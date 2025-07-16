//
//  ViewController.swift
//  UserDefaultsTask2
//
//  Created by Mateusz Krówczyński on 16/07/2025.
//

import UIKit

final class LoginViewController: UIViewController {
    private let loginService: LoginService
    
    required init?(coder: NSCoder) {
        self.loginService = LoginService()
        super.init(coder: coder)
    }
    
    init(loginService: LoginService) {
        self.loginService = loginService
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActions()
        setupUI()
    }
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        loginService.userEmail = email
        loginService.isLoggedIn = true
    }
    
    private func addActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginButton)
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            emailTextField.widthAnchor.constraint(equalToConstant: 200),
            
            loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

#Preview {
    LoginViewController(loginService: LoginService())
}


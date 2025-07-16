//
//  MainScreenViewController.swift
//  UserDefaultsTask2
//
//  Created by Mateusz Krówczyński on 16/07/2025.
//

import UIKit

final class MainScreenViewController: UIViewController {
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
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func logoutTapped() {
        loginService.logout()
    }
    
    private func addActions() {
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Main Screen"
        
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
    MainScreenViewController(loginService: LoginService())
}



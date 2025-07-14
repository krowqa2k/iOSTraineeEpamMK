//
//  ViewController.swift
//  Task1Notifications
//
//  Created by Mateusz Krówczyński on 14/07/2025.
//

import UIKit

class ViewController: UIViewController {
    private let notificationCenter: NotificationCenter = .default

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActions()
    }

    private lazy var notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Notification", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(notificationButton)
        
        NSLayoutConstraint.activate([
            notificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notificationButton.widthAnchor.constraint(equalToConstant: 200),
            notificationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func addActions() {
        notificationButton.addTarget(self, action: #selector(sendNotificationTapped), for: .touchUpInside)
    }
    
    
    @objc private func sendNotificationTapped() {
        showLabelViewController {
            let name = Notification.Name(notificationName)
            self.notificationCenter.post(name: name, object: nil, userInfo: ["message": "Hello from Task1Notifications!"])
            print("Notification sent!")
        }
    }
    
    private func showLabelViewController(completion: (() -> Void)? = nil) {
        let labelViewController = NotificationObserverViewController()
        labelViewController.modalPresentationStyle = .pageSheet
        present(labelViewController, animated: true, completion: completion)
    }
}

#Preview {
    ViewController()
}


//
//  NotificationObserverViewController.swift
//  Task1Notifications
//
//  Created by Mateusz Krówczyński on 14/07/2025.
//

import UIKit

let notificationName: String = "CustomNotificationTask1"

class NotificationObserverViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createObservers()
    }
    
    let customNotiName = Notification.Name(notificationName)
    
    private lazy var notificatonLabel: UILabel = {
        let label = UILabel()
        label.text = "No notifications yet"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(notificatonLabel)
        NSLayoutConstraint.activate([
            notificatonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificatonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: customNotiName, object: nil)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let message = userInfo["message"] as? String else {
            return
        }
        
        DispatchQueue.main.async {
            self.notificatonLabel.text = message
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

#Preview {
    NotificationObserverViewController()
}

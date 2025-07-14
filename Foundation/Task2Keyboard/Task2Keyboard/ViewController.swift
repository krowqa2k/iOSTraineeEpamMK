//
//  ViewController.swift
//  Task2Keyboard
//
//  Created by Mateusz Krówczyński on 14/07/2025.
//

import UIKit

class ViewController: UIViewController {
    let notificationCenter: NotificationCenter = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActions()
        addObservers()
    }
    
    private lazy var textField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Type here..."
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private lazy var hideKeyboardButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Hide Keyboard", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(textField)
        view.addSubview(hideKeyboardButton)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            hideKeyboardButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            hideKeyboardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideKeyboardButton.widthAnchor.constraint(equalToConstant: 200),
            hideKeyboardButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func keyboardWillChange(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        view.frame.origin.y = notification.name == UIResponder.keyboardWillHideNotification ? 0 : -keyboardFrame.height
    }
    
    private func addActions() {
        hideKeyboardButton.addTarget(self, action: #selector(hideKeyboardTapped), for: .touchUpInside)
    }
    
    @objc private func hideKeyboardTapped() {
        textField.resignFirstResponder()
    }
    
    private func addObservers() {
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

#Preview {
    ViewController()
}


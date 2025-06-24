//
//  Task3ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
import Combine

// Lay out login screen as in the attached screen recording.
// 1. Content should respect safe area guides
// 2. Content should be visible on all screen sizes
// 3. Content should be spaced on bottom as in the recording
// 4. When keyboard appears, content should move up
// 5. When you tap the screen and keyboard gets dismissed, content should move down
// 6. You can use container views/layout guides or any option you find useful
// 7. Content should have horizontal spacing of 16
// 8. Title and description labels should have a vertical spacing of 12 from each other
// 9. Textfields should have a spacing of 40 from top labels
// 10. Login button should have 16 spacing from textfields
final class Task3ViewController: UIViewController {
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let logInButton = UIButton()
    
    private let contentView = UIView()
    private var contentViewBottomConstraint: NSLayoutConstraint!
    
    private let horizontalPadding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        setupGestures()
        setupKeyboardObservers()
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(usernameField)
        contentView.addSubview(passwordField)
        contentView.addSubview(logInButton)
        
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        contentViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupLabels()
        setupTextFields()
        setupButton()
    }
    
    private func setupLabels() {
        titleLabel.text = "Sign In"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.textColor = .label
        
        bodyLabel.numberOfLines = 0
        bodyLabel.text = """
          Lorem ipsum dolor sit amet, consectetur adipiscing elit,
          sed do eiusmod tempor incididunt ut labore
          """
        bodyLabel.font = .systemFont(ofSize: 16)
        
        NSLayoutConstraint.activate(
            [
                bodyLabel.bottomAnchor.constraint(equalTo: usernameField.topAnchor, constant: -40),
                bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
                bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
                
                titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -12),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
                titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20)
            ]
        )
    }
    
    private func setupTextFields() {
        usernameField.placeholder = "Enter username"
        passwordField.placeholder = "Enter password"
        usernameField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        
        NSLayoutConstraint.activate(
            [
                passwordField.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -16),
                passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
                passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
                passwordField.heightAnchor.constraint(equalToConstant: 44),
                
                usernameField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -16),
                usernameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
                usernameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
                usernameField.heightAnchor.constraint(equalToConstant: 44),
            ]
        )
    }
    
    private func setupButton() {
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.systemBlue, for: .normal)
        logInButton.titleLabel?.font = .systemFont(ofSize: 17)
        
        NSLayoutConstraint.activate(
            [
                logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ]
        )
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        let bottomInset = view.safeAreaInsets.bottom
        contentViewBottomConstraint.constant = -(keyboardHeight - bottomInset)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded() 
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        contentViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

#Preview {
    Task3ViewController()
}

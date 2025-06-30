//
//  ViewController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

final class PersonalInfoViewController: UIViewController {
    weak var onboardingDelegate: OnboardingDataDelegate?

        private let nameTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Enter your name"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()

        private let phoneTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Enter your phone number"
            textField.keyboardType = .phonePad
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()

        private lazy var confirmButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Confirm", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.isEnabled = false 
            button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        var userName: String?
        var userPhoneNumber: String?

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Personal Info"
            setupUI()
            nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

            if let name = userName {
                nameTextField.text = name
            }
            if let phone = userPhoneNumber {
                phoneTextField.text = phone
            }
            updateConfirmButtonState()
        }

        private func setupUI() {
            let stackView = UIStackView(arrangedSubviews: [nameTextField, phoneTextField, confirmButton])
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                nameTextField.heightAnchor.constraint(equalToConstant: 44),
                phoneTextField.heightAnchor.constraint(equalToConstant: 44),
                confirmButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

        @objc private func textFieldDidChange() {
            updateConfirmButtonState()
        }

        private func updateConfirmButtonState() {
            let isNameEmpty = nameTextField.text?.isEmpty ?? true
            let isPhoneNumberValid = (phoneTextField.text?.count ?? 0) >= 9
            confirmButton.isEnabled = !isNameEmpty && isPhoneNumberValid
        }

        @objc private func confirmButtonTapped() {
            let name = nameTextField.text ?? ""
            let phone = phoneTextField.text ?? ""

            let alertController = UIAlertController(title: "Confirm Information",message: "Please confirm your name and phone number. Name: \(name), Phone: \(phone).",preferredStyle: .alert)

            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.onboardingDelegate?.didUpdatePersonalInfo(name: name, phoneNumber: phone)
                let preferencesVC = PreferencesViewController()
                preferencesVC.onboardingDelegate = self.onboardingDelegate
                preferencesVC.userName = name
                preferencesVC.userPhoneNumber = phone
                self.navigationController?.pushViewController(preferencesVC, animated: true)
            }

            let editAction = UIAlertAction(title: "Edit", style: .cancel) { _ in }

            alertController.addAction(confirmAction)
            alertController.addAction(editAction)
            present(alertController, animated: true, completion: nil)
        }
}


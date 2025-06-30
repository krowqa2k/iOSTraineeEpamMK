//
//  ConfirmDetailsViewController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

final class ConfirmDetailsViewController: UIViewController {

    weak var onboardingDelegate: OnboardingDataDelegate?

    var userName: String?
    var userPhoneNumber: String?
    var selectedNotificationPreference: String?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let preferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startOverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start over", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startOverTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var editPreferencesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit preferences", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(editPreferencesTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var editPersonalInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit personal info", for: .normal)
        button.backgroundColor = .systemTeal
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(editPersonalInfoTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(confirmOnboardingTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Confirm Details"
        navigationItem.hidesBackButton = true
        setupUI()
        displaySummary()
    }

    private func setupUI() {
        let summaryStackView = UIStackView(arrangedSubviews: [nameLabel, phoneLabel, preferenceLabel])
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 10
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryStackView)

        let buttonStackView = UIStackView(arrangedSubviews: [startOverButton, editPreferencesButton, editPersonalInfoButton, confirmButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 15
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            summaryStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            summaryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            summaryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 50),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startOverButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func displaySummary() {
        nameLabel.text = "Name: \(userName ?? "N/A")"
        phoneLabel.text = "Phone Number: \(userPhoneNumber ?? "N/A")"
        preferenceLabel.text = "Notification Preference: \(selectedNotificationPreference ?? "N/A")"
    }

    @objc private func startOverTapped() {
        if let onboardingVC = navigationController?.viewControllers.first(where: { $0 is OnboardingViewController }) as? OnboardingViewController {
            onboardingVC.isRestartMode = true
            navigationController?.popToViewController(onboardingVC, animated: true)
        }
    }

    @objc private func editPreferencesTapped() {
        if let preferencesVC = navigationController?.viewControllers.last(where: { $0 is PreferencesViewController }) as? PreferencesViewController {
            navigationController?.popToViewController(preferencesVC, animated: true)
        }
    }

    @objc private func editPersonalInfoTapped() {
        if let personalInfoVC = navigationController?.viewControllers.last(where: { $0 is PersonalInfoViewController }) as? PersonalInfoViewController {
            navigationController?.popToViewController(personalInfoVC, animated: true)
        } else if let personalInfoVC = navigationController?.viewControllers.first(where: { $0 is PersonalInfoViewController }) as? PersonalInfoViewController {
            navigationController?.popToViewController(personalInfoVC, animated: true)
        } else {
            let personalInfoVC = PersonalInfoViewController()
            personalInfoVC.onboardingDelegate = onboardingDelegate
            personalInfoVC.userName = userName
            personalInfoVC.userPhoneNumber = userPhoneNumber
            navigationController?.pushViewController(personalInfoVC, animated: true)
        }
    }

    @objc private func confirmOnboardingTapped() {
        let alert = UIAlertController(title: "Onboarding Complete!", message: "You have successfully passed the onboarding process.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let onboardingVC = self?.navigationController?.viewControllers.first(where: { $0 is OnboardingViewController }) as? OnboardingViewController {
                onboardingVC.isRestartMode = true
                self?.navigationController?.popToViewController(onboardingVC, animated: true)
            }
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

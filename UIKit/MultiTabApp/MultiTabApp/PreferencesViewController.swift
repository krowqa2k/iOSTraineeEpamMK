//
//  PreferencesViewController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

final class PreferencesViewController: UIViewController {

    weak var onboardingDelegate: OnboardingDataDelegate?

    private lazy var selectPreferenceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Notification Preference", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(selectPreferenceTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let selectedPreferenceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "No preference selected"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var userName: String?
    var userPhoneNumber: String?
    var selectedNotificationPreference: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Preferences"
        setupUI()
    }

    private func setupUI() {
        view.addSubview(selectPreferenceButton)
        view.addSubview(selectedPreferenceLabel)

        NSLayoutConstraint.activate([
            selectPreferenceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPreferenceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            selectPreferenceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectPreferenceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectPreferenceButton.heightAnchor.constraint(equalToConstant: 50),

            selectedPreferenceLabel.topAnchor.constraint(equalTo: selectPreferenceButton.bottomAnchor, constant: 20),
            selectedPreferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedPreferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedPreferenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc private func selectPreferenceTapped() {
        let actionSheet = UIAlertController(title: "Select Notification Preference", message: nil, preferredStyle: .actionSheet)

        let emailAction = UIAlertAction(title: "Email Notifications", style: .default) { [weak self] _ in
            self?.updatePreference(preference: "Email Notifications")
        }

        let smsAction = UIAlertAction(title: "SMS Notifications", style: .default) { [weak self] _ in
            self?.updatePreference(preference: "SMS Notifications")
        }

        let pushAction = UIAlertAction(title: "Push Notifications", style: .default) { [weak self] _ in
            self?.updatePreference(preference: "Push Notifications")
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(emailAction)
        actionSheet.addAction(smsAction)
        actionSheet.addAction(pushAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true)
    }

    private func updatePreference(preference: String) {
        selectedNotificationPreference = preference
        selectedPreferenceLabel.text = "Current Choice: \(preference)"
        onboardingDelegate?.didUpdateNotificationPreference(preference: preference)

        let confirmDetailsVC = ConfirmDetailsViewController()
        confirmDetailsVC.onboardingDelegate = onboardingDelegate
        confirmDetailsVC.userName = userName
        confirmDetailsVC.userPhoneNumber = userPhoneNumber
        confirmDetailsVC.selectedNotificationPreference = selectedNotificationPreference
        navigationController?.pushViewController(confirmDetailsVC, animated: true)
    }
}

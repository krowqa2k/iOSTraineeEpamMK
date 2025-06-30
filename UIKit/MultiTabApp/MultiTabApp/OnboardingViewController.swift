//
//  OnboardingViewController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import Foundation
import UIKit

final class OnboardingViewController: UIViewController {
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var isRestartMode: Bool = false {
        didSet {
            if isRestartMode {
                startButton.setTitle("Restart", for: .normal)
                startButton.backgroundColor = .systemGreen
            } else {
                startButton.setTitle("Start", for: .normal)
                startButton.backgroundColor = .systemBlue
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Onboarding"
        setupStartButton()
    }

    private func setupStartButton() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func startButtonTapped() {
        let personalInfoVC = PersonalInfoViewController()
        personalInfoVC.onboardingDelegate = self
        navigationController?.pushViewController(personalInfoVC, animated: true)
    }
}

extension OnboardingViewController: OnboardingDataDelegate {
    func didUpdatePersonalInfo(name: String?, phoneNumber: String?) { }

    func didUpdateNotificationPreference(preference: String?) { }
}

protocol OnboardingDataDelegate: AnyObject {
    func didUpdatePersonalInfo(name: String?, phoneNumber: String?)
    func didUpdateNotificationPreference(preference: String?)
}

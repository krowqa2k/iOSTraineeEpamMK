//
//  EditProfileViewController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

class EditProfileViewController: UIViewController {

    private let visualizationLabel: UILabel = {
        let label = UILabel()
        label.text = "You are in Edit Profile"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = "Edit profile"
        setupUI()
        print("EditProfileViewController: viewDidLoad()")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EditProfileViewController: viewWillAppear()")
        view.backgroundColor = .systemGray4
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EditProfileViewController: viewDidAppear()")
        visualizationLabel.textColor = .blue
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EditProfileViewController: viewWillLayoutSubviews()")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EditProfileViewController: viewDidLayoutSubviews()")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EditProfileViewController: viewWillDisappear()")
        view.backgroundColor = .systemGray5
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EditProfileViewController: viewDidDisappear()")
    }

    private func setupUI() {
        view.addSubview(visualizationLabel)
        NSLayoutConstraint.activate([
            visualizationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            visualizationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//
//  ProfileViewController.swift
//  MultiTabApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default User Name"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit profile", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"
        setupUI()
        setupNavigationBarButtons()
        print("ProfileViewController: viewDidLoad()")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileViewController: viewWillAppear()")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileViewController: viewDidAppear()")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ProfileViewController: viewWillLayoutSubviews()")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ProfileViewController: viewDidLayoutSubviews()")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ProfileViewController: viewWillDisappear()")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ProfileViewController: viewDidDisappear()")
    }

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(editProfileButton)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            editProfileButton.widthAnchor.constraint(equalToConstant: 200),
            editProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupNavigationBarButtons() {
        let editNameButton = UIBarButtonItem(image: UIImage(systemName: "pencil.slash"), style: .plain, target: self, action: #selector(editNameButtonTapped))
        let anonymousButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(anonymousButtonTapped))
        navigationItem.rightBarButtonItems = [anonymousButton, editNameButton]
    }

    @objc private func editNameButtonTapped() {
        let alert = UIAlertController(title: "Edit Name", message: "Enter a new name:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New name"
        }
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self?.nameLabel.text = newName
            } else {
                self?.nameLabel.text = "Default"
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    @objc private func anonymousButtonTapped() {
        nameLabel.text = "Anonymous"
    }

    @objc private func editProfileTapped() {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}

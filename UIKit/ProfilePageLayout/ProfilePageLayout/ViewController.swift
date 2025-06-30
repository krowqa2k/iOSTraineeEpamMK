//
//  ViewController.swift
//  ProfilePageLayout
//
//  Created by Mateusz Krówczyński on 30/06/2025.
//

import UIKit

final class ViewController: UIViewController {

    let userName: String = "Mateusz Krówczyński"
    let userBio: String = "iOS Junior Trainee at EPAM."
    let followersCount: Int = 1234
    let followingCount: Int = 567
    let postsCount: Int = 89

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()

    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return button
    }()

    let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private func createStatisticLabel(value: String, description: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        let attributedString = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        attributedString.append(NSAttributedString(string: description, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.gray]))
        label.attributedText = attributedString
        return label
    }

    lazy var followersLabel: UILabel = {
        return createStatisticLabel(value: "\(followersCount)", description: "Followers")
    }()

    lazy var followingLabel: UILabel = {
        return createStatisticLabel(value: "\(followingCount)", description: "Following")
    }()

    lazy var postsLabel: UILabel = {
        return createStatisticLabel(value: "\(postsCount)", description: "Posts")
    }()

    let taggedPostsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Tagged Posts"
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let profileHeaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()

    let statisticsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let followersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    let followingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    let postsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupData()
        setupLayout()
        setupActions()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.addTaggedPostsSection()
        }
    }

    private func setupData() {
        nameLabel.text = userName
        bioLabel.text = userBio
    }

    private func setupLayout() {
        userInfoStackView.addArrangedSubview(nameLabel)
        userInfoStackView.addArrangedSubview(followButton)
        
        profileHeaderStackView.addArrangedSubview(profileImageView)
        profileHeaderStackView.addArrangedSubview(userInfoStackView)
        
        followersStackView.addArrangedSubview(followersLabel)
        followingStackView.addArrangedSubview(followingLabel)
        postsStackView.addArrangedSubview(postsLabel)
        
        statisticsStackView.addArrangedSubview(followersStackView)
        statisticsStackView.addArrangedSubview(followingStackView)
        statisticsStackView.addArrangedSubview(postsStackView)
        
        mainStackView.addArrangedSubview(profileHeaderStackView)
        mainStackView.addArrangedSubview(bioLabel)
        mainStackView.addArrangedSubview(statisticsStackView)
        mainStackView.addArrangedSubview(taggedPostsLabel)

        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        profileHeaderStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor).isActive = true
        profileHeaderStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor).isActive = true

        statisticsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        bioLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        taggedPostsLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
    }
    
    private func setupActions() {
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
    }

    @objc private func followButtonTapped() {
        self.followButton.setTitle("Following", for: .normal)
        self.followButton.isUserInteractionEnabled = false
    }
    
    private func addTaggedPostsSection() {
        UIView.animate(withDuration: 0.5) {
            self.taggedPostsLabel.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
}


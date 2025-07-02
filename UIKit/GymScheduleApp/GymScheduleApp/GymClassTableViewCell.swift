//
//  GymClassTableViewCell.swift
//  GymScheduleApp
//
//  Created by Mateusz Krówczyński on 02/07/2025.
//

import UIKit

class GymClassTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "GymClassCell"
    
    private lazy var classNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trainerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trainerPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBlue
        return button
    }()
    
    weak var delegate: GymClassCellDelegate?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(classNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(trainerPhotoImageView)
        contentView.addSubview(trainerNameLabel)
        contentView.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            trainerPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trainerPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            trainerPhotoImageView.widthAnchor.constraint(equalToConstant: 40),
            trainerPhotoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            classNameLabel.leadingAnchor.constraint(equalTo: trainerPhotoImageView.trailingAnchor, constant: 12),
            classNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            classNameLabel.trailingAnchor.constraint(equalTo: registerButton.leadingAnchor, constant: -16),
            
            timeLabel.leadingAnchor.constraint(equalTo: classNameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor, constant: 4),
            
            durationLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8),
            durationLabel.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor, constant: 4),
            
            trainerNameLabel.leadingAnchor.constraint(equalTo: classNameLabel.leadingAnchor),
            trainerNameLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            trainerNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            registerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 44),
            registerButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupActions() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func configure(with gymClass: GymClassModel, at indexPath: IndexPath) {
        self.indexPath = indexPath
        classNameLabel.text = gymClass.name
        timeLabel.text = gymClass.time
        durationLabel.text = "\(gymClass.duration) minutes"
        trainerNameLabel.text = gymClass.trainer.fullName
        trainerPhotoImageView.image = UIImage(systemName: "person.circle.fill")
        updateRegisterButton(isRegistered: gymClass.isRegistered)
    }
    
    private func updateRegisterButton(isRegistered: Bool) {
        let imageName = isRegistered ? "xmark.circle.fill" : "plus.circle.fill"
        registerButton.setImage(UIImage(systemName: imageName), for: .normal)
        registerButton.tintColor = isRegistered ? .systemRed : .systemGreen
    }
    
    @objc private func registerButtonTapped() {
        delegate?.didTapRegisterButton(for: self)
    }
}

protocol GymClassCellDelegate: AnyObject {
    func didTapRegisterButton(for cell: GymClassTableViewCell)
}

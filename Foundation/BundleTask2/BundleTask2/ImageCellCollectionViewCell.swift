//
//  ImageCellCollectionViewCell.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activityIndicator.stopAnimating()
    }

    func configure(with imageURL: URL) {
        activityIndicator.startAnimating()

        Task {
            let downloadedImage = await ImageDownloader.shared.downloadImage(from: imageURL.absoluteString)
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let image = downloadedImage {
                    self.imageView.image = image
                } else {
                    self.imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                    self.imageView.tintColor = .systemRed
                }
            }
        }
    }
}

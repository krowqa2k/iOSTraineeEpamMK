//
//  ImageCollectionViewCell.swift
//  BundleTask3
//
//  Created by Mateusz Krówczyński on 28/07/2025.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with imageName: String, cornerRadius: CGFloat) {
        contentView.layer.cornerRadius = cornerRadius
        imageView.layer.cornerRadius = cornerRadius
        contentView.clipsToBounds = true
        
        let bundledImage = UIImage(named: imageName)
        
        Task {
            await MainActor.run {
                if let image = bundledImage {
                    self.imageView.image = image
                } else {
                    self.imageView.image = UIImage(systemName: "photo")
                }
            }
        }
    }
}

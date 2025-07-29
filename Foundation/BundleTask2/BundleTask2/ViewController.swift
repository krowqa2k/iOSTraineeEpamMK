//
//  ViewController.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import UIKit

final class ViewController: UIViewController {

    private let imageURLs: [String] = [
        "https://picsum.photos/id/0/5000/3333",
        "https://picsum.photos/id/1/5000/3333",
        "https://picsum.photos/id/2/5000/3333",
        "https://picsum.photos/id/3/5000/3333",
        "https://picsum.photos/id/4/5000/3333",
        "https://picsum.photos/id/5/5000/3333",
        "https://picsum.photos/id/6/5000/3333"
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private let cacheSizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let clearCacheButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear cache", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(cacheSizeLabel)
        view.addSubview(clearCacheButton)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: clearCacheButton.topAnchor, constant: -10),

            clearCacheButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clearCacheButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearCacheButton.bottomAnchor.constraint(equalTo: cacheSizeLabel.topAnchor, constant: -10),
            clearCacheButton.heightAnchor.constraint(equalToConstant: 50),

            cacheSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cacheSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cacheSizeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            cacheSizeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        clearCacheButton.addTarget(self, action: #selector(clearCacheTapped), for: .touchUpInside)
    }
    
    @objc private func clearCacheTapped() {
        ImageCacheManager.shared.clearCache()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Error dequeuing ImageCollectionViewCell")
        }
            
        let urlString = imageURLs[indexPath.item]
        
        if let url = URL(string: urlString) {
            cell.configure(with: url)
        } else {
            cell.imageView.image = UIImage(systemName: "xmark.octagon.fill")
            cell.imageView.tintColor = .systemGray
            cell.activityIndicator.stopAnimating()
        }
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let width: CGFloat = view.bounds.width
        let itemsPerRow: CGFloat = 3
        let totalHorizontalInset = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let totalSpacing = (itemsPerRow - 1) * flowLayout.minimumInteritemSpacing
        let availableWidth = width - totalHorizontalInset - totalSpacing
        let widthPerItem = floor(availableWidth / itemsPerRow)
        let heightPerItem = widthPerItem * 1.2

        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

#Preview {
    ViewController()
}


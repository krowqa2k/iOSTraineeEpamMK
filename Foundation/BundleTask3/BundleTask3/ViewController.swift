//
//  ViewController.swift
//  BundleTask3
//
//  Created by Mateusz Krówczyński on 28/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var appConfig: AppConfig?
    private var imagesToDisplay: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appConfig = ConfigManager.shared.loadConfiguration()
        configureAppFeatures()
        setupUI()
    }
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureAppFeatures() {
        guard let config = appConfig else {
            print("Failed to load app configuration. Using default values.")
            titleLabel.text = "Default App Title"
            imagesToDisplay = ["photo.fill", "photo.fill", "photo.fill"]
            return
        }
        
        titleLabel.text = config.appTitle
        let endIndex = config.maxImageCount
        
        imagesToDisplay = Array(config.imageFileNames.prefix(endIndex))
        
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }
        
        let imageName = imagesToDisplay[indexPath.item]
        let cornerRadius = appConfig?.cellCornerRadius ?? 8.0
        cell.configure(with: imageName, cornerRadius: cornerRadius)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let itemsPerRow: CGFloat = 3
        
        let totalHorizontalInset = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let totalInteritemSpacing = flowLayout.minimumInteritemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - totalHorizontalInset - totalInteritemSpacing
        
        let widthPerItem = floor(availableWidth / itemsPerRow)
        let heightPerItem = widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

#Preview {
    ViewController()
}

//
//  ViewController.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import UIKit

final class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let imageURLs: [URL] = [
        URL(string: "https://picsum.photos/200/300")!,
        URL(string: "https://picsum.photos/200/301")!,
        URL(string: "https://picsum.photos/200/302")!,
        URL(string: "https://picsum.photos/200/303")!,
        URL(string: "https://picsum.photos/200/304")!,
        URL(string: "https://picsum.photos/200/305")!
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
    
    // Etykieta do wyświetlania rozmiaru cache'u
    private let cacheSizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Przycisk do pobierania wszystkich obrazów
    private let downloadAllImagesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pobierz wszystkie obrazy", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Przycisk do czyszczenia cache'u (teraz w głównym widoku)
    private let clearCacheButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Wyczyść cache", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(cacheSizeLabel)
        view.addSubview(downloadAllImagesButton)
        view.addSubview(clearCacheButton) // Dodano przycisk czyszczenia cache'u do widoku

        // Ustawienie ograniczeń Auto Layout
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Kolekcja kończy się nad przyciskiem pobierania
            collectionView.bottomAnchor.constraint(equalTo: downloadAllImagesButton.topAnchor, constant: -20),

            downloadAllImagesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadAllImagesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            // Przycisk pobierania nad przyciskiem czyszczenia cache'u
            downloadAllImagesButton.bottomAnchor.constraint(equalTo: clearCacheButton.topAnchor, constant: -10),
            downloadAllImagesButton.heightAnchor.constraint(equalToConstant: 50),

            clearCacheButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clearCacheButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            // Przycisk czyszczenia cache'u nad etykietą rozmiaru cache'u
            clearCacheButton.bottomAnchor.constraint(equalTo: cacheSizeLabel.topAnchor, constant: -10),
            clearCacheButton.heightAnchor.constraint(equalToConstant: 50),

            cacheSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cacheSizeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cacheSizeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            cacheSizeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Podłączenie akcji do przycisków
        downloadAllImagesButton.addTarget(self, action: #selector(downloadAllImagesTapped), for: .touchUpInside)
        clearCacheButton.addTarget(self, action: #selector(clearCacheTapped), for: .touchUpInside)
    }
    
    @objc private func clearCacheTapped() {
        ImageCacheManager.shared.clearCache()
    }

    @objc private func downloadAllImagesTapped() {
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Nie można deque komórki ImageCollectionViewCell")
        }
        
        let url = imageURLs[indexPath.item]
        cell.configure(with: url)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }

        let sectionInsetLeft = flowLayout.sectionInset.left
        let sectionInsetRight = flowLayout.sectionInset.right
        let minimumInteritemSpacing = flowLayout.minimumInteritemSpacing

        let totalSpacing = sectionInsetLeft + sectionInsetRight + (minimumInteritemSpacing * 2)
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / 3
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

#Preview {
    ViewController()
}


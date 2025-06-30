//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

final class ViewController: UIViewController {
    
    var images: [ImageItem] = [] {
        didSet {
            groupImagesByYear()
            collectionView.reloadData()
        }
    }
    
    var groupedImages: [Int: [ImageItem]] = [:]
    var sortedYears: [Int] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImages()
        updateCollectionViewLayout(for: view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.updateCollectionViewLayout(for: size)
        })
    }
    
    private func setupUI() {
        title = "My Photo Gallery"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadImages() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        images = [
            ImageItem(imageName: "photo", title: "Photo", date: dateFormatter.date(from: "2023-01-15")!, isFavorite: false),
            ImageItem(imageName: "camera.fill", title: "Camera", date: dateFormatter.date(from: "2023-03-22")!, isFavorite: true),
            ImageItem(imageName: "cloud.fill", title: "Cloud", date: dateFormatter.date(from: "2023-07-01")!, isFavorite: false),
            ImageItem(imageName: "sun.max.fill", title: "Sun", date: dateFormatter.date(from: "2024-01-05")!, isFavorite: false),
            ImageItem(imageName: "moon.fill", title: "Moon", date: dateFormatter.date(from: "2024-02-10")!, isFavorite: true),
            ImageItem(imageName: "star.fill", title: "Star", date: dateFormatter.date(from: "2024-04-18")!, isFavorite: false),
            ImageItem(imageName: "heart.fill", title: "Heart", date: dateFormatter.date(from: "2023-09-01")!, isFavorite: true),
            ImageItem(imageName: "leaf.fill", title: "Leaf", date: dateFormatter.date(from: "2025-01-20")!, isFavorite: false),
            ImageItem(imageName: "pawprint.fill", title: "Paw", date: dateFormatter.date(from: "2025-03-05")!, isFavorite: false),
            ImageItem(imageName: "bicycle", title: "Bicycle", date: dateFormatter.date(from: "2024-06-25")!, isFavorite: false),
            ImageItem(imageName: "car.fill", title: "Car", date: dateFormatter.date(from: "2025-05-12")!, isFavorite: true),
            ImageItem(imageName: "airplane", title: "Airplane", date: dateFormatter.date(from: "2023-11-30")!, isFavorite: false),
        ]
    }
    
    private func groupImagesByYear() {
        groupedImages = Dictionary(grouping: images) { item in
            Calendar.current.component(.year, from: item.date)
        }
        sortedYears = groupedImages.keys.sorted { $0 > $1 }
    }
    
    private func updateCollectionViewLayout(for size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let sectionInsets = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        let interitemSpacing: CGFloat = 5
        let lineSpacing: CGFloat = 5
        
        let totalHorizontalPadding = sectionInsets.left + sectionInsets.right
        
        var numberOfColumns: CGFloat
        if size.width > size.height {
            numberOfColumns = 5
        } else {
            numberOfColumns = 3
        }
        
        let availableWidth = size.width - totalHorizontalPadding - (interitemSpacing * (numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        layout.minimumInteritemSpacing = interitemSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = sectionInsets
        layout.headerReferenceSize = CGSize(width: size.width, height: 50)
        
        layout.invalidateLayout()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sortedYears.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let year = sortedYears[section]
        return groupedImages[year]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else {
            fatalError("Error creating ImageCell")
        }
        
        let year = sortedYears[indexPath.section]
        guard let itemsInYear = groupedImages[year] else { return cell }
        
        let item = itemsInYear[indexPath.item]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as? SectionHeaderView else {
            fatalError("Error creating SectionHeaderView")
        }
        
        let year = sortedYears[indexPath.section]
        header.configure(with: "\(year)")
        return header
    }
}

extension ViewController: ImageCellDelegate {
    func imageCell(_ cell: ImageCell, didToggleFavoriteFor imageItem: ImageItem) {
        if let index = images.firstIndex(where: { $0.id == imageItem.id }) {
            images[index].isFavorite.toggle()
            
            cell.updateFavoriteButton(isFavorite: images[index].isFavorite)
            
            let message = images[index].isFavorite ?
                "Marked \(images[index].title) as Favorite!" :
                "Removed \(images[index].title) from Favorites!"
            showAlert(title: "Favorite", message: message)
        }
    }
}

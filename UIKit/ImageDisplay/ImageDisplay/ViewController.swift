//
//  ViewController.swift
//  ImageDisplay
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import UIKit

final class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "UIKitImage")
        imageView.contentMode = .scaleAspectFit
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        
        scrollView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = 1.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentSize()
        centerImage()
    }
    
    func updateContentSize() {
        guard let image = imageView.image else { return }
        
        let imageSize = image.size
        let scrollViewSize = scrollView.bounds.size
        
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        let imageWidth = imageSize.width * minScale
        let imageHeight = imageSize.height * minScale
        
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        scrollView.contentSize = CGSize(width: imageWidth, height: imageHeight)
    }
    
    func centerImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        
        let horizontalSpace = max(0, (scrollViewSize.width - imageSize.width) / 2)
        let verticalSpace = max(0, (scrollViewSize.height - imageSize.height) / 2)
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalSpace + 20,
            left: horizontalSpace + 20,
            bottom: verticalSpace + 20,
            right: horizontalSpace + 20
        )
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}

//
//  ImageDownloader.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import Foundation
import UIKit

final class ImageDownloader {
    private let cacheManager = ImageCacheManager.shared
    static let shared = ImageDownloader()
    private init() {}
    
    func downloadImage(from urlString: String) async -> UIImage? {
        if let cachedImage = cacheManager.loadImage(for: urlString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            
            if let image = image {
                cacheManager.saveImage(image, for: urlString)
                return image
            } else {
                print("Failed to create image from data.")
                return nil
            }
        } catch {
            print("Error downloading image from \(urlString): \(error.localizedDescription)")
            return nil
        }
    }
}

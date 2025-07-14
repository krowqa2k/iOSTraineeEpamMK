//
//  ImageDownloader.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import Foundation
import UIKit

final class ImageDownloader {
    private let cache = ImageCacheManager.shared
    static let shared = ImageDownloader()
    
    private init() {}
    
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return nil
        }
        
        if let cachedImage = cache.loadImage(for: url) {
            print("Returning cached image for URL: \(urlString)")
            return cachedImage
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            cache.saveImage(image, for: url)
            return image
        } catch {
            print("Error downloading image: \(error.localizedDescription)")
            return nil
        }
    }
}

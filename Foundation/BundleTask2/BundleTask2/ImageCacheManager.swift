//
//  FileManager.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = fileManager.temporaryDirectory.appendingPathComponent("ImageCache")
        createCacheDirectoryIfNeeded()
    }
    
    private func createCacheDirectoryIfNeeded() {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    @objc private func clearCacheOnMemoryWarning() {
        clearCache()
    }
    
    private func fileName(for url: String) -> String {
        return url.replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ":", with: "_")
    }
    
    func saveImage(_ image: UIImage, for url: String) {
        let filename = fileName(for: url)
        let fileURL = cacheDirectory.appendingPathComponent(filename)
        
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: fileURL)
        }
    }
    
    func loadImage(for url: String) -> UIImage? {
        let filename = fileName(for: url)
        let fileURL = cacheDirectory.appendingPathComponent(filename)
        
        guard fileManager.fileExists(atPath: fileURL.path),
              let data = try? Data(contentsOf: fileURL) else { return nil }
        
        print("Loading image from cache: \(fileURL.path)")
        return UIImage(data: data)
    }
    
    func clearCache() {
        guard let files = try? fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil) else { return }
        
        for file in files {
            try? fileManager.removeItem(at: file)
        }
        
        print("Cache cleared")
    }
}

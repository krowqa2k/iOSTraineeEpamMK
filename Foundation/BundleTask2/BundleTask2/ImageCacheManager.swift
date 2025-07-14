//
//  FileManager.swift
//  BundleTask2
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import Foundation
import UIKit

final class ImageCacheManager {
    let fileManager = FileManager.default
    static let shared = ImageCacheManager()
    
    private let cacheSubDirectoryName = "PicsumImageCache"
    
    private lazy var cacheDirectoryURL: URL? = {
        let tempDirectory = FileManager.default.temporaryDirectory
        let cacheDir = tempDirectory.appendingPathComponent(cacheSubDirectoryName)
        
        if !FileManager.default.fileExists(atPath: cacheDir.path) {
            do {
                try FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating cache directory: \(error.localizedDescription)")
                return nil
            }
        }
        return cacheDir
    }()
    
    private init() {}
    
    private func fileName(for url: URL) -> String? {
        return url.absoluteString.data(using: .utf8)?.base64EncodedString()
    }
    
    private func fileURL(for url: URL) -> URL? {
        guard let cacheDir = cacheDirectoryURL, let filename = fileName(for: url) else { return nil }
        return cacheDir.appendingPathComponent(filename)
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        guard let fileURL = fileURL(for: url) else {
            print("Failed to get file URL for image cache.")
            return
        }
        
        guard let imageData = image.pngData() else {
            print("Failed to convert image to PNG data.")
            return
        }
        
        do {
            try imageData.write(to: fileURL, options: .atomic)
        } catch {
            print("Error saving image to cache: \(error.localizedDescription)")
        }
    }
    
    func loadImage(for url: URL) -> UIImage? {
        guard let fileURL = fileURL(for: url) else { return nil }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image from cache: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func clearCache() {
        guard let cacheDir = cacheDirectoryURL else { return }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: cacheDir, includingPropertiesForKeys: nil, options: [])
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
            print("Cache cleared successfully.")
        } catch {
            print("Error clearing cache: \(error.localizedDescription)")
        }
    }
}

//
//  AppConfig.swift
//  BundleTask3
//
//  Created by Mateusz Krówczyński on 28/07/2025.
//

import Foundation

struct AppConfig: Codable {
    let appTitle: String
    let imageFileNames: [String]
    let cellCornerRadius: CGFloat
    let maxImageCount: Int
}

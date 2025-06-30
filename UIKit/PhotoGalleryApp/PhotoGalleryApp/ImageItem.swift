//
//  ImageItem.swift
//  PhotoGalleryApp
//
//  Created by Mateusz Krówczyński on 29/06/2025.
//

import Foundation

struct ImageItem {
    let id: UUID = UUID()
    let imageName: String
    let title: String
    let date: Date
    var isFavorite: Bool
}

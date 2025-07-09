//
//  TVSeriesModel.swift
//  Task2Movies
//
//  Created by Mateusz Krówczyński on 09/07/2025.
//

import Foundation

struct TVSeriesResponse: Codable {
    let page: Int
    let results: [TVSeriesModel]
    let totalPages: Int
    let totalResults: Int
}

struct TVSeriesModel: Codable {
    let name: String
    let firstAirDate: String
    let voteAverage: Double
    let originCountry: [String]
    let popularity: Double
    let posterPath: String
    let backdropPath: String
    let overview: String
}

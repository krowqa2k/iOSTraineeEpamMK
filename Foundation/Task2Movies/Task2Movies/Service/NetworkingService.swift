//
//  NetworkingService.swift
//  Task2Movies
//
//  Created by Mateusz Krówczyński on 09/07/2025.
//

import Foundation
import UIKit

final class NetworkingService {
    private let baseURL = "https://api.themoviedb.org/3/tv"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private let apiKey = "7481bbcf1fcb56bd957cfe9af78205f3"
    
    private let cacheImage = NSCache<NSString, UIImage>()
    
    func fetchTopRatedSeries() async throws -> [TVSeriesModel] {
        var components = URLComponents(string: baseURL + "/top_rated")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: String(1))
        ]
        
        guard let url = components?.url else {
            throw NetworkingErrorCases.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let tvSeriesResponse = try decoder.decode(TVSeriesResponse.self, from: data)
            return tvSeriesResponse.results
        } catch {
            throw NetworkingErrorCases.decodingError
        }
    }
    
    func fetchImage(path: String?) async throws -> UIImage {
        guard let path = path else {
            throw NetworkingErrorCases.invalidPosterPath
        }
        
        let fullURLString = imageBaseURL + path
        
        guard let url = URL(string: fullURLString) else {
            throw NetworkingErrorCases.invalidURL
        }
        
        if let cacheImage = cacheImage.object(forKey: fullURLString as NSString) {
            return cacheImage
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingErrorCases.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkingErrorCases.decodingError
        }
        
        cacheImage.setObject(image, forKey: fullURLString as NSString)
        return image
    }
}

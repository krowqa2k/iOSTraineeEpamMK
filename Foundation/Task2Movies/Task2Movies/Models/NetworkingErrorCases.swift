//
//  NetworkingErrorCases.swift
//  Task2Movies
//
//  Created by Mateusz Krówczyński on 09/07/2025.
//

import Foundation

enum NetworkingErrorCases: LocalizedError {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidPosterPath
    case decodingError
    
    var localizedDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .requestFailed:
            return "The network request failed. Please check your connection."
        case .invalidResponse:
            return "The response from the server was invalid."
        case .invalidPosterPath:
            return "The poster path provided is invalid."
        case .decodingError:
            return "There was an error decoding the response data."
        }
    }
}

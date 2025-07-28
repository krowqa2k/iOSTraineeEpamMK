//
//  ConfigManager.swift
//  BundleTask3
//
//  Created by Mateusz Krówczyński on 28/07/2025.
//

import Foundation

final class ConfigManager {
    static let shared = ConfigManager()
    private init() { }
    
    private let configFileName = "config"
    
    func loadConfiguration() -> AppConfig? {
        guard let url = Bundle.main.url(forResource: configFileName, withExtension: "json") else {
            print("Config file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let configuration = try decoder.decode(AppConfig.self, from: data)
            return configuration
        } catch {
            print("Error loading configuration: \(error.localizedDescription)")
            return nil
        }
    }
}

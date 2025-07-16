//
//  LoginService.swift
//  UserDefaultsTask2
//
//  Created by Mateusz Krówczyński on 16/07/2025.
//

import Foundation

final class LoginService {
    private let defaults = UserDefaults.standard
    private let loginDefaultsKey: String = "loginDefaultsKey"
    private let userDefaultsEmailKey: String = "userDefaultsEmailKey"
    
    var isLoggedIn: Bool {
        get {
            defaults.bool(forKey: loginDefaultsKey)
        }
        set {
            defaults.set(newValue, forKey: loginDefaultsKey)
            NotificationCenter.default.post(name: Notification.Name("loginStateChanged"), object: nil)
        }
    }
    
    var userEmail: String? {
        get {
            defaults.string(forKey: userDefaultsEmailKey)
        }
        set {
            defaults.set(newValue, forKey: userDefaultsEmailKey)
        }
    }
    
    func login(email: String) {
        userEmail = email
        isLoggedIn = true
    }
    
    func logout() {
        userEmail = nil
        isLoggedIn = false
    }
}

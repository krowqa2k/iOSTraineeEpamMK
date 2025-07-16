//
//  ViewController.swift
//  UserDefaultsTask1
//
//  Created by Mateusz Krówczyński on 16/07/2025.
//

import UIKit

class ViewController: UIViewController {
    private let userDefaults = UserDefaults.standard
    private let themeKey = "selectedTheme"

    override func viewDidLoad() {
        super.viewDidLoad()
        addActions()
        setupUI()
        loadSavedTheme()
    }

    private lazy var lightDarkModePicker: UISegmentedControl = {
        let picker = UISegmentedControl(items: ["Light", "Dark"])
        picker.selectedSegmentIndex = 0
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    @objc private func themeChanged() {
        let selectedTheme = lightDarkModePicker.selectedSegmentIndex == 0 ? "Light" : "Dark"
        userDefaults.set(selectedTheme, forKey: themeKey)
        
        if selectedTheme == "Dark" {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    private func loadSavedTheme() {
        if let savedTheme = userDefaults.string(forKey: themeKey) {
            lightDarkModePicker.selectedSegmentIndex = savedTheme == "Light" ? 0 : 1
            themeChanged()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(lightDarkModePicker)
        NSLayoutConstraint.activate([
            lightDarkModePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lightDarkModePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lightDarkModePicker.widthAnchor.constraint(equalToConstant: 200),
            lightDarkModePicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addActions() {
        lightDarkModePicker.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
    }
}

#Preview {
    ViewController()
}

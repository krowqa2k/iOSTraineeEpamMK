//
//  Task6View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct UserSettings {
    let title: String
    var isEnabled: Bool
}

struct Task6View: View {
    @State private var userSettings: [UserSettings] = [
        UserSettings(title: "Light Mode", isEnabled: true),
        UserSettings(title: "Notifications", isEnabled: false),
        UserSettings(title: "Background refresh", isEnabled: true),
        UserSettings(title: "Live activities", isEnabled: false)
    ]
    
    var body: some View {
        List {
            ForEach($userSettings, id: \.title) { $setting in
                Toggle(setting.title, isOn: $setting.isEnabled)
            }
        }
    }
}

#Preview {
    Task6View()
}

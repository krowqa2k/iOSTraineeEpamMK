//
//  Task4View.swift
//  Navigation
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task4View: View {
    var body: some View {
        NavigationStack {
            Task4HomeView()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: Task4SettingsView()) {
                            Text("Settings")
                                .font(.headline)
                        }
                    }
                }
        }
    }
}

struct Task4HomeView: View {
    var body: some View {
        Text("Welcome to Task 4 App!")
            .font(.title)
            .navigationTitle("My App!")
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
    }
}

struct Task4SettingsView: View {
    var body: some View {
        Text("Settings screen")
            .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    Task4View()
}

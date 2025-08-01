//
//  Task2View.swift
//  Navigation
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

enum Destination: Hashable {
    case profile
    case settings
}

struct Task2View: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .profile:
                        ProfileView(path: $path)
                    case .settings:
                        SettingsView(path: $path)
                    }
                }
        }
    }
}

struct HomeView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Button {
            path.append(Destination.settings)
        } label: {
            Text("Go to Settings")
        }
    }
}

struct SettingsView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Button {
            path.append(Destination.profile)
        } label: {
            Text("Go to Profile")
        }
    }
}

struct ProfileView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Button {
            path.removeLast(path.count)
        } label: {
            Text("Got to Home")
        }
    }
}

#Preview {
    Task2View()
}

//
//  Task4View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task4View: View {
    @State private var isLightModeOn: Bool = true
    
    var body: some View {
        ZStack {
            Color(isLightModeOn ? .white : .black)
            
            Toggle("", isOn: $isLightModeOn)
                .padding()
                .toggleStyle(BackgroundChangingToggleStyle())
        }
        .animation(.smooth, value: isLightModeOn)
        .ignoresSafeArea()
    }
}

struct BackgroundChangingToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Text(configuration.isOn ? "Light Mode" : "Dark Mode")

            Button {
                configuration.isOn.toggle()
            } label: {
                ZStack {
                    Circle()
                        .fill(configuration.isOn ? Color.yellow : Color.white)
                        .frame(width: 32, height: 32)
                }
            }
            .buttonStyle(.plain)
        }
        .font(.title3)
        .foregroundColor(configuration.isOn ? .black : .white)
    }
}

#Preview {
    Task4View()
}


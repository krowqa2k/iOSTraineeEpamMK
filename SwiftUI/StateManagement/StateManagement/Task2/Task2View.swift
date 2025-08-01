//
//  Task2View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task2View: View {
    @State private var showText: Bool = false
    
    var body: some View {
        VStack {
            Toggle("Show Text", isOn: $showText)
            
            if showText {
                Text("Hello, SwiftUI!")
            }
        }
        .animation(.smooth, value: showText)
        .padding()
    }
}

#Preview {
    Task2View()
}

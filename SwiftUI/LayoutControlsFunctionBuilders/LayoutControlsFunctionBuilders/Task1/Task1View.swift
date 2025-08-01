//
//  Task1View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task1View: View {
    @State private var showGreeting: Bool = false
    
    var body: some View {
        VStack {
            Toggle("Show Greeting", isOn: $showGreeting)
            
            if showGreeting {
                Text("Hello, SwiftUI!")
            }
        }
        .animation(.smooth, value: showGreeting)
        .padding()
    }
}

#Preview {
    Task1View()
}

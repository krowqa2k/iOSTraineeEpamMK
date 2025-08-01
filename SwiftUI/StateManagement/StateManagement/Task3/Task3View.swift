//
//  Task3View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task3View: View {
    @State var isOn: Bool = false
    
    var body: some View {
        VStack {
            Text("Toggle state in parent view: \(isOn.description)")
            
            Task3BindingView(isOn: $isOn)
        }
    }
}

struct Task3BindingView: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle("Child view toggle", isOn: $isOn)
            .padding()
    }
}

#Preview {
    Task3View()
}

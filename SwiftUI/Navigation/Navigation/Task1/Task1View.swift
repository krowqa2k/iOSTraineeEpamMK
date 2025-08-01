//
//  Task1View.swift
//  Navigation
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task1View: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                
                NavigationLink("Go to second view") {
                    Task1SecondView()
                }
            }
        }
    }
}

struct Task1SecondView: View {
    var body: some View {
        Text("Hello, SwiftUI Navigation!")
    }
}

#Preview {
    Task1View()
}

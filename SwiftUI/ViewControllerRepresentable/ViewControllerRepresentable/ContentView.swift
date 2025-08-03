//
//  ContentView.swift
//  ViewControllerRepresentable
//
//  Created by Mateusz Krówczyński on 03/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, from SwiftUI!")
            
            EmbededUIKitView()
                .frame(height: 55)
        }
        .padding()
    }
}

struct EmbededUIKitView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    
    func makeCoordinator() -> () { }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

#Preview {
    ContentView()
}

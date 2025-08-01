//
//  Task5View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task5View: View {
    var body: some View {
        VStack(spacing: 24) {
            CardView(title: "Mateusz Krówczyński") {
                HStack {
                    Text("iOS Developer")
                    
                    Image(systemName: "apple.logo")
                }
            }
            
            CardView(title: "Error Card") {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                    
                    VStack(alignment: .leading) {
                        Text("Something went wrong")
                        Text("Please try again later.")
                    }
                }
            }
            
            CardView(title: "Course Progress") {
                VStack(alignment: .leading) {
                    Text("Your current progress")
                        .font(.headline)
                    
                    ProgressView(value: 0.75)
                        .tint(.green)
                }
            }
        }
        .padding()
    }
}

struct CardView<Content:View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Text(title)
            
            content
                .padding(8)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    Task5View()
}

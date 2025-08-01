//
//  Task3View.swift
//  Navigation
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task3View: View {
    private let items: [String] = ["Apple", "Banana", "Cherry"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(destination: FruitDetailView(fruitName: item)) {
                        Text(item)
                    }
                }
            }
        }
    }
}

struct FruitDetailView: View {
    @State private var showAdditionalInfo: Bool = false
    let fruitName: String
    
    var body: some View {
        VStack {
            Text(fruitName)
            
            Button("Show More Info") {
                showAdditionalInfo.toggle()
            }
        }
        .sheet(isPresented: $showAdditionalInfo) {
            Text("\(fruitName) is a delicious fruit!")
                .font(.headline)
                .padding()
        }
    }
}

#Preview {
    Task3View()
}

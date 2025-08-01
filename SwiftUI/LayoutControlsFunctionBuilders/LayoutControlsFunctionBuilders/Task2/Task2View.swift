//
//  Task2View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task2View: View {
    private let names: [String] = ["Mateusz", "Kate", "John", "Alice", "Bob"]
    
    var body: some View {
        List(names, id: \.self) { name in
            HStack {
                Text(name)
                
                Spacer()
                
                Button {
                    print("\(name)")
                } label: {
                    Text("Tap")
                }

            }
        }
    }
}

#Preview {
    Task2View()
}

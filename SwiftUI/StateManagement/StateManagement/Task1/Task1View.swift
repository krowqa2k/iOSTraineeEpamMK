//
//  Task1View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task1View: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack(spacing: 12){
            Text("\(counter)")
                .font(.title)
                .bold()
            
            Button {
                counter += 1
            } label: {
                Text("+1")
                    .font(.headline)
            }
        }
    }
}

#Preview {
    Task1View()
}

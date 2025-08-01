//
//  Task4View.swift
//  LayoutModifiers
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task4View: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(Color.blue)
                .offset(x: -200, y: -350)
            
            Rectangle()
                .frame(width: 200, height: 100)
                .foregroundStyle(Color.green)
                .offset(x: 150, y: -200)
        }
    }
}

#Preview {
    Task4View()
}

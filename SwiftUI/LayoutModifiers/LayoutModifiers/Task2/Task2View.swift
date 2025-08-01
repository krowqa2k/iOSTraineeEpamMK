//
//  Task2View.swift
//  LayoutModifiers
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task2View: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 100)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 50)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
    }
}

#Preview {
    Task2View()
}

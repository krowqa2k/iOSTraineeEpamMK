//
//  Task5View.swift
//  LayoutModifiers
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task5View: View {
    var body: some View {
        Text("SwiftUI is amazing!")
            .background(Color.gray)
            .overlay {
                Circle()
                    .opacity(0.5)
            }
            .clipShape(Circle())
    }
}

#Preview {
    Task5View()
}

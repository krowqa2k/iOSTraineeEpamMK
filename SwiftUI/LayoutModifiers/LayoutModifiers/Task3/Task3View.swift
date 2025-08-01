//
//  Task3View.swift
//  LayoutModifiers
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task3View: View {
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .padding()
    }
}

#Preview {
    Task3View()
}

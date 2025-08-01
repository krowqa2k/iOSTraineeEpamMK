//
//  Task1View.swift
//  LayoutModifiers
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task1View: View {
    var body: some View {
        Text("SwiftUI Layout Modifiers")
            .padding(.top, 16)
            .padding(.bottom, 12)
            .padding(.leading, 8)
            .padding(.trailing, 12)
            .background(Color.blue)
    }
}

#Preview {
    Task1View()
}

//
//  Task6View.swift
//  LayoutModifiers
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task6View: View {
    @State private var isEnabled: Bool = false
    
    var body: some View {
        VStack {
            Button("Custom Button") {
                isEnabled.toggle()
            }
            .modifier(CustomButtonModifier(font: .title3, foregroundStyle: .black, backgroundStyle: .green, shape: Rectangle(), isEnabled: isEnabled))
        }
    }
}

struct CustomButtonModifier<S: Shape>: ViewModifier {
    var font: Font
    var foregroundStyle: Color
    var backgroundStyle: Color
    var shape: S
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(foregroundStyle)
            .background(isEnabled ? backgroundStyle : Color.gray)
            .clipShape(shape)
    }
}

#Preview {
    Task6View()
}

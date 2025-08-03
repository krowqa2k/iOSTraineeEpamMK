//
//  TextView.swift
//  HostingController
//
//  Created by Mateusz Krówczyński on 03/08/2025.
//

import SwiftUI

struct TextView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Hello, SwiftUI!")
        
        Button("Dismiss") {
            dismiss()
        }
        .tint(.red)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    TextView()
}

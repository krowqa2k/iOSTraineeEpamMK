//
//  DecrementCounterView.swift
//  SharedCounterExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct DecrementCounterView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Button("Decrement") {
            counter.counterValue -= 1
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
    }
}

#Preview {
    DecrementCounterView()
}

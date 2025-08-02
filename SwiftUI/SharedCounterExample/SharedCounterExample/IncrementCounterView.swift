//
//  IncrementCounterView.swift
//  SharedCounterExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct IncrementCounterView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Button("Increment") {
            counter.counterValue += 1
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
    }
}

#Preview {
    IncrementCounterView()
}

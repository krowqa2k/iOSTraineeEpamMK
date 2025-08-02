//
//  CounterDisplayView.swift
//  SharedCounterExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct CounterDisplayView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Text("Counter Value: \(counter.counterValue)")
    }
}

#Preview {
    CounterDisplayView()
}

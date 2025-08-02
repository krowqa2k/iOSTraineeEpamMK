//
//  ContentView.swift
//  SharedCounterExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var counter = Counter()
    
    var body: some View {
        VStack(spacing: 24) {
            CounterDisplayView()
                .environmentObject(counter)
            
            IncrementCounterView()
                .environmentObject(counter)
            
            DecrementCounterView()
                .environmentObject(counter)
        }
        .padding()
    }
}

#Preview {
    RootView()
}

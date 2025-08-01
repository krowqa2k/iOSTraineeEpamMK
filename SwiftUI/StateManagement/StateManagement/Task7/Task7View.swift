//
//  Task7View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

@Observable
final class Counter {
    var count: Int = 0
}

struct Task7View: View {
    @State private var counter = Counter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("First view count: \(counter.count)")
                
                Button("Increment") {
                    counter.count += 1
                }
            }
            
            Task7SecondCounterView(counter: counter)
        }
    }
}

struct Task7SecondCounterView: View {
    @Bindable var counter: Counter
    
    var body: some View {
        HStack {
            Text("Second view count: \(counter.count)")
            
            Button("Increment") {
                counter.count += 1
            }
        }
    }
}

#Preview {
    Task7View()
}

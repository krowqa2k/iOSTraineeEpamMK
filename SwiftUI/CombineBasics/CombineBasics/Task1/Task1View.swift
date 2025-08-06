//
//  Task1View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class JustPublisherExample {
    private var cancellables = Set<AnyCancellable>()
    
    func justExample() {
        Just("Hello, Combine!")
            .sink {
                print($0)
            }
            .store(in: &cancellables)
    }
}

struct Task1View: View {
    let example = JustPublisherExample()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                example.justExample()
            }
    }
}

#Preview {
    Task1View()
}

//
//  Task2View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class FuturePublisherExample {
    private var cancellables = Set<AnyCancellable>()
    
    func futureExample() {
        let future = Future<String, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success("Hello, from Future!"))
            }
        }
        
        future
            .sink { value in
                print("\(value)")
            }
            .store(in: &cancellables)
    }
}

struct Task2View: View {
    let example = FuturePublisherExample()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                example.futureExample()
            }
    }
}

#Preview {
    Task2View()
}

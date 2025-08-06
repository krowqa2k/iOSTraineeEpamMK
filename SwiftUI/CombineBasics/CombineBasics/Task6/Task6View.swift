//
//  Task6.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class PassthroughSubjectFlatMapExample {
    private var subject = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    func passthroughSubjectFlatMapExample() {
        subject
            .flatMap { value -> Just<Int> in
                Just(value * value)
            }
            .sink { value in
                print("\(value)")
            }
            .store(in: &cancellables)
        
        for i in 1...10 {
            subject.send(i)
        }
    }
}

struct Task6View: View {
    private let example = PassthroughSubjectFlatMapExample()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                example.passthroughSubjectFlatMapExample()
            }
    }
}

#Preview {
    Task6View()
}

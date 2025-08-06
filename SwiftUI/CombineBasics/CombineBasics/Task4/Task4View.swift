//
//  Task4View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class PassthroughSubjectExample {
    private var subject = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    func passthroughSubjectExample() {
        subject
            .filter { $0.isMultiple(of: 2) }
            .sink { value in
                print("\(value)")
            }
            .store(in: &cancellables)
        
        for i in 1...50 {
            subject.send(i)
        }
    }
}

struct Task4View: View {
    private let example = PassthroughSubjectExample()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                example.passthroughSubjectExample()
            }
    }
}

#Preview {
    Task4View()
}

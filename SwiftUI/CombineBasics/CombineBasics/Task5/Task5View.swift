//
//  Task5View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class DebounceExample {
    private let textPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    func debounceExample() {
        textPublisher
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { print($0) }
            .store(in: &cancellables)
        
        let stringArray = ["H", "He", "Hel", "Hell", "Hello"]
        
        for (index, string) in stringArray.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                self.textPublisher.send(string)
            }
        }
    }
}

struct Task5View: View {
    private let example = DebounceExample()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                example.debounceExample()
            }
    }
}

#Preview {
    Task5View()
}

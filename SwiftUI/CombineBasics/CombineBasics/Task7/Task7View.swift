//
//  Task7View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class Task7ViewModel: ObservableObject {
    @Published var counter: Int = 0
    
    private var buttonPassthroughSubject = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    func incrementCounter() {
        buttonPassthroughSubject.send(1)
    }
    
    private func setupBindings() {
        buttonPassthroughSubject
            .sink { [weak self] value in
                self?.counter += value
                print("Button press count: \(self?.counter ?? 0)")
            }
            .store(in: &cancellables)
    }
}

struct Task7View: View {
    @StateObject private var viewModel = Task7ViewModel()
    
    var body: some View {
        VStack {
            Text("Counter: \(viewModel.counter)")
                .font(.largeTitle)
            
            Button("Increment Counter") {
                viewModel.incrementCounter()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    Task7View()
}

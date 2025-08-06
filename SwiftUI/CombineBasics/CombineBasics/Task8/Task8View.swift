//
//  Task8View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class Task8ViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var loadingState: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    func getLoadingState() {
        $isLoading
            .map { isLoading in
                isLoading ? "Loading..." : "Loaded"
            }
            .sink { [weak self] value in
                self?.loadingState = value
                print("Loading state changed to: \(value)")
            }
            .store(in: &cancellables)
    }
}

struct Task8View: View {
    @StateObject private var viewModel = Task8ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.loadingState)
                .font(.largeTitle)
            
            Button("Toggle Loading State") {
                viewModel.isLoading.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            viewModel.getLoadingState()
        }
    }
}

#Preview {
    Task8View()
}

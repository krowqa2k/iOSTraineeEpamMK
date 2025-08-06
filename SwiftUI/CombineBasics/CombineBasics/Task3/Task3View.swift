//
//  Task3View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

final class TwoPublishersExample {
    private let name = Just("Mateusz")
    private let surname = Just("Krówczyński")
    
    private var cancellables = Set<AnyCancellable>()
    
    func combinePublishersExample() {
        let capitalizedName = name
            .map { $0.uppercased() }
        
        let lowercasedSurname = surname
            .map { $0.lowercased() }
        
        capitalizedName
            .combineLatest(lowercasedSurname)
            .sink { name, surname in
                print("\(name) \(surname)")
            }
            .store(in: &cancellables)
    }

}

struct Task3View: View {
    private let example = TwoPublishersExample()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                example.combinePublishersExample()
            }
    }
}

#Preview {
    Task3View()
}

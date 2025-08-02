//
//  Counter.swift
//  SharedCounterExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import Foundation

final class Counter: ObservableObject {
    @Published var counterValue: Int = 0
}

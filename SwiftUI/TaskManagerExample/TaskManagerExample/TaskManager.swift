//
//  TaskManager.swift
//  TaskManagerExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import Foundation

final class TaskManager: ObservableObject {
    @Published var tasks: [String] = []
    
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

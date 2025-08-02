//
//  RemoveTaskView.swift
//  TaskManagerExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct RemoveTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        List {
            ForEach(taskManager.tasks, id: \.self) { task in
                Text(task)
            }
            .onDelete(perform: taskManager.removeTask)
        }
        .navigationTitle("Remove Task")
    }
}

#Preview {
    NavigationStack {
        RemoveTaskView()
            .environmentObject(TaskManager())
    }
}

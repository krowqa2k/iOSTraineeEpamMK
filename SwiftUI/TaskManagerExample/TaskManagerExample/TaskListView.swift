//
//  TaskListView.swift
//  TaskManagerExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        List(taskManager.tasks, id: \.self) { task in
            Text(task)
        }
        .navigationTitle("Tasks")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    RemoveTaskView()
                        .environmentObject(taskManager)
                } label: {
                    Image(systemName: "trash")
                        .font(.title3)
                        .foregroundStyle(.red)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddTaskView()
                        .environmentObject(taskManager)
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskListView()
            .environmentObject(TaskManager())
    }
}

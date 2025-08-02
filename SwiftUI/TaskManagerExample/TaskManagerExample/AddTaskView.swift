//
//  AddTaskView.swift
//  TaskManagerExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @Environment(\.dismiss) private var dismiss
    @State private var taskTitle: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter task title...", text: $taskTitle)
                .textFieldStyle(.roundedBorder)
            
            Button("Add Task") {
                guard !taskTitle.isEmpty else { return }
                
                taskManager.tasks.append(taskTitle)
                taskTitle = ""
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(taskTitle.isEmpty)
        }
        .padding()
        .navigationTitle("Add Task")
    }
}

#Preview {
    NavigationStack {
        AddTaskView()
            .environmentObject(TaskManager())
    }
}

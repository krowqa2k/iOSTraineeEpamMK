//
//  ContentView.swift
//  TaskManagerExample
//
//  Created by Mateusz Krówczyński on 02/08/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
        NavigationStack {
            TaskListView()
                .environmentObject(taskManager)
        }
    }
}

#Preview {
    RootView()
}

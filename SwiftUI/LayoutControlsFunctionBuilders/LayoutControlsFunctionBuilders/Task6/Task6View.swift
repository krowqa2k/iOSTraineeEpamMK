//
//  Task6View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task {
    var title: String
    var isEnabled: Bool
}

struct Task6View: View {
    @State private var tasks: [Task] = [
        Task(title: "Finish Task 6", isEnabled: true),
        Task(title: "Finish Task 7", isEnabled: false),
        Task(title: "Send finished tasks", isEnabled: false)
    ]

    var body: some View {
        List {
            ForEach($tasks, id: \.title) { $task in
                HStack {
                    Text(task.title)
                    
                    Spacer()
                    
                    Toggle("", isOn: $task.isEnabled)
                }
            }
        }
    }
}

#Preview {
    Task6View()
}

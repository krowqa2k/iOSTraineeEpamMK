//
//  Task5View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

@Observable
final class FormModel {
    var username: String = ""
}

struct Task5View: View {
    @State private var formModel: FormModel = FormModel()
    
    var body: some View {
        VStack {
            TextField("Username", text: $formModel.username)
                .textFieldStyle(.roundedBorder)
            
            Button("Submit") {
                print("Submitted username: \(formModel.username)")
            }
            .disabled(formModel.username.isEmpty)
        }
        .padding()
    }
}

#Preview {
    Task5View()
}

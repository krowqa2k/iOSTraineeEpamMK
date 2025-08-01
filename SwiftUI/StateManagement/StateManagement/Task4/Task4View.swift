//
//  Task4View.swift
//  StateManagement
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

@Observable
final class UserProfile {
    var name: String = ""
    var email: String = ""
}

struct Task4View: View {
    @State private var profile: UserProfile = UserProfile()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            VStack(alignment: .leading) {
                Text("User's Profile")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text("Name: \(profile.name)")
                    Text("Email: \(profile.email)")
                }
            }
            
            VStack {
                TextField("Name", text: $profile.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $profile.email)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
    }
}

#Preview {
    Task4View()
}

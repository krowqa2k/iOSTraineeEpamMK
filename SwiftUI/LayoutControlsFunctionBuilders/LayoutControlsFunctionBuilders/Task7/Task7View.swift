//
//  Task7View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct User {
    let name: String
    let age: Int
    let location: String
    let isPremium: Bool
}

struct Task7View: View {
    private let users: [User] = [
        User(name: "Mateusz Krówczyński", age: 23, location: "Wrocław, Poland", isPremium: false),
        User(name: "John Doe", age: 26, location: "Warsaw, Poland", isPremium: true)
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(users, id: \.name) { user in
                ProfileDetailView(user: user)
            }
        }
    }
}

struct ProfileDetailView: View {
    let user: User
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                Text(user.name)
                    .font(.headline)
                
                HStack(alignment: .bottom) {
                    Text(user.location)
                    
                    Text("Age \(user.age)")
                        .font(.footnote)
                }
            }
            
            if user.isPremium {
                Text("Premium Badge")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    Task7View()
}

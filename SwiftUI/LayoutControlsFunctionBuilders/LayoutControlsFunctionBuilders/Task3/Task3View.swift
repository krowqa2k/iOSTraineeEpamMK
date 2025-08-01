//
//  Task3View.swift
//  LayoutControlsFunctionBuilders
//
//  Created by Mateusz Krówczyński on 01/08/2025.
//

import SwiftUI

struct Task3View: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text("Mateusz")
                
                Text("iOS EPAM Trainee")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    Task3View()
}

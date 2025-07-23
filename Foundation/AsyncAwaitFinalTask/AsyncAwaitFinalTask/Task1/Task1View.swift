//
//  SwiftUIView.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct Task1View: View, @unchecked Sendable {
    let task1API = Task1API()
    @State var fact = "To get random number fact presss button below"

    var body: some View {
        VStack {
            Text(fact)
                .padding()
            Button(action: {
                Task {
                    self.fact = try await task1API.getTrivia(for: .none) ?? "loading error"
                }
            }, label: { Text("Click me") })
        }
    }
}

#Preview {
    Task1View()
}

class Task1API: @unchecked Sendable {
    let baseURL = "http://numbersapi.com"
    let triviaPath = "random/trivia"
    private var session = URLSession.shared

    func getTrivia(for number: Int?) async throws -> String? {
        guard let url = URL(string: baseURL)?.appendingPathComponent(triviaPath) else {
            return nil
        }
        print(url)
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response from server")
                return nil
            }
            
            let fact = String(data: data, encoding: .utf8)
            return fact
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
    }

}

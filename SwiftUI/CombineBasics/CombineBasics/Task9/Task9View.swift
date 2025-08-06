//
//  Task9View.swift
//  CombineBasics
//
//  Created by Mateusz Krówczyński on 06/08/2025.
//

import Combine
import SwiftUI

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
}

final class Task9ViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    private let urlSession: URLSession = .shared
    private let urlString = "https://jsonplaceholder.typicode.com/posts"
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}

struct Task9View: View {
    @StateObject private var viewModel = Task9ViewModel()
    
    var body: some View {
        List(viewModel.posts) { post in
            Text(post.title)
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    Task9View()
}

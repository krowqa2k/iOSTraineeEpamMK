import Foundation
import PlaygroundSupport

enum ErrorCases: LocalizedError {
    case badURL
    case networkError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL provided is invalid."
        case .networkError:
            return "There was a problem with the network request."
        case .decodingError:
            return "Failed to decode the response data."
        }
    }
}

struct UserEmails: Codable {
    let email: String
}

func fetchEmails() async throws -> [UserEmails] {
    let urlString = URL(string: "https://jsonplaceholder.typicode.com/users")
    
    guard let url = urlString else { throw ErrorCases.badURL }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw ErrorCases.networkError
    }
    
    do {
        let decoder = JSONDecoder()
        let emails = try decoder.decode([UserEmails].self, from: data)
        return emails
    } catch {
        throw ErrorCases.decodingError
    }
}

Task {
    do {
        let emails = try await fetchEmails()
        for user in emails {
            print(user.email)
        }
    } catch {
        switch error {
        case ErrorCases.badURL, ErrorCases.networkError, ErrorCases.decodingError:
            print(error.localizedDescription)
        default:
            print("An unexpected error occurred: \(error.localizedDescription)")
        }
    }
}

//
//  User.swift
//  UnitTesting
//

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.email == rhs.email
    }
}

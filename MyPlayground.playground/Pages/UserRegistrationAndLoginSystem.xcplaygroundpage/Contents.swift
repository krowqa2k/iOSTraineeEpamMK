import Foundation

struct User {
    let username: String
    var email: String
    var password: String
}

class UserManager {
    var users: [String: User] = [:]
    
    var userCount: Int {
        users.count
    }
    
    func registerUser(username: String, email: String, password: String) -> Bool {
        guard users[username] == nil else { return false }
        
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser
        
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        guard let storedUser = users[username] else {
            return false
        }
        
        if storedUser.password == password {
            return true
        } else {
            return false
        }
    }
    
    func removeUser(username: String) -> Bool {
        guard users[username] != nil else { return false }
        
        users.removeValue(forKey: username)
        
        return true
    }
}

class AdminUser: UserManager {
    func listAllUsers() -> [String] {
        var usernames: [String] = []
        
        for user in users.values {
            usernames.append(user.username)
        }
        
        return usernames
    }
    
    deinit {
        print("Admin instance is removed from memory")
    }
}


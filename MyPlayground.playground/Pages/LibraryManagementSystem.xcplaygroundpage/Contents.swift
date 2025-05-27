import Foundation

protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    mutating func checkIn()
    func isOverdue() -> Bool
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let returnDate = returnDate else {
            return false
        }
        
        return Date() > returnDate
    }
    
    mutating func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}

class Item {
    let id: String
    let title: String
    let author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
    
    override init(id: String, title: String, author: String) {
        super.init(id: id, title: title, author: author)
    }
}

enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}

class Library {
    var items: [String: Item] = [:]
    
    func addBook(_ book: Book) {
        let key = book.id
        items[key] = book
    }
    
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard var borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        
        borrowableItem.isBorrowed = true
        borrowableItem.borrowDate = Date()
        
        return item
    }
}

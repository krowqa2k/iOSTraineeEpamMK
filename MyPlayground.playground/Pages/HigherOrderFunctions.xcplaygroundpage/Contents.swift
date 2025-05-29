import Foundation

let books = [
["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]

var discountedPrices: [Double] = books.compactMap {
    guard let price = $0["price"] as? Int else { return nil }
    
    let discountedPrice = Double(price) * 0.9
    return discountedPrice
}

var booksPostedAfter2000: [String] = books.filter {
    guard let year = $0["year"] as? Int else { return false }
    return year > 2000
}.compactMap {
    return $0["title"] as? String
}

var allGenres: Set<String> = Set(books.flatMap {
    return ($0["genre"] as? [String]) ?? []
})

let totalCost: Int = books.reduce(0) { cost, currentBook in
    let price = (currentBook["price"] as? Int) ?? 0
    
    return cost + price
}


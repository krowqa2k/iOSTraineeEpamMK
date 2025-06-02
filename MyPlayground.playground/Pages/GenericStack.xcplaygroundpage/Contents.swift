import Foundation

class Stack<T> {
    var stackItems: [T] = []
    
    func push(_ element: T) {
        stackItems.append(element)
    }
    
    func pop() -> T? {
        guard !stackItems.isEmpty else { return nil }
        
        return stackItems.removeLast()
    }
    
    func size() -> Int {
        return stackItems.count
    }
    
    func printStackContents() -> String {
        guard !stackItems.isEmpty else { return "" }
        
        return stackItems.reversed().map { "\($0)" }.joined(separator: ", ")
    }
}

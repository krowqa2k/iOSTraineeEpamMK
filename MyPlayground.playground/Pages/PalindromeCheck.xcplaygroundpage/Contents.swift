import Foundation

// The solution should ignore spaces, punctuation, capitalization and control characters.
// The solution should not use any third-party libraries or regular expressions.
// The solution should not consider an empty string or a single character as a palindrome.

public func isPalindrome(input: String) -> Bool {
    var textToCheck: String = ""
    
    for character in input {
        if character.isLetter {
            textToCheck.append(character)
        }
    }
    
    guard !textToCheck.isEmpty else { return false }
    guard textToCheck.count > 1 else { return false }
    
    let reversedText: String = String(textToCheck.reversed())
    
    if textToCheck.lowercased() == reversedText.lowercased() { return true }
    
    return false
}

isPalindrome(input: "Racecar")

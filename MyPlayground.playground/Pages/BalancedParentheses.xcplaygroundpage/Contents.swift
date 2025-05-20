import Foundation

public func isBalancedParentheses(input: String) -> Bool {
    var balance = 0

    for character in input {
        if character == "(" {
            balance += 1
        } else if character == ")" {
            balance -= 1
        }

        if balance < 0 {
            return false
        }
    }

    if balance == 0 { return true }
    return false
}

isBalancedParentheses(input: "(())")
isBalancedParentheses(input: "(()")


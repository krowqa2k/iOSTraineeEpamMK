//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let randomNum = Double.random(in: 1...100)
        let randomDivisor = Double.random(in: 1...10)
        XCTAssertNoThrow(try calculator.divide(randomNum, randomDivisor), "Expected no error when dividing by non-zero")
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        let randomNum = Double.random(in: 1...100)
        let zeroDivisor = 0.0
        
        XCTAssertThrowsError(try calculator.divide(randomNum, zeroDivisor)) { error in
            let returnedError = error as? Calculator.CalculatorError
            XCTAssertEqual(returnedError, Calculator.CalculatorError.divisionByZero)
        }
    }

    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        let num = 12
        XCTAssertTrue(calculator.isGreaterThanTen(num))
    }
    
    func test_isLessThanTen() {
        let num = 8
        XCTAssertFalse(calculator.isGreaterThanTen(num))
    }
    
    func test_isEqualToTen() {
        let num = 10
        XCTAssertFalse(calculator.isGreaterThanTen(num))
    }
    
    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let randomNum = Double.random(in: 1...100)
        let result = calculator.safeSquareRoot(randomNum)
        
        XCTAssertNotNil(result)
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let randomNegativeNum = Double.random(in: -100...0)
        let result = calculator.safeSquareRoot(randomNegativeNum)
        
        XCTAssertNil(result)
    }
}

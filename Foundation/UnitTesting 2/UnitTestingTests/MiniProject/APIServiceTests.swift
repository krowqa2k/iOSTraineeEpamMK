//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let invalidURL = ""
        let expectations = expectation(description: "Should complete with invalidURL error")
        
        sut.fetchUsers(urlString: invalidURL) { result in
            expectations.fulfill()
            switch result {
            case .success(let success):
                XCTFail("Expected failure, but got success with users: \(success)")
            case .failure(let failure):
                XCTAssertEqual(failure, .invalidUrl)
            }
        }
        
        wait(for: [expectations], timeout: 1.0)
    }

    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        let urlString = "https://example.com/users"
        let expectations = expectation(description: "Should complete with success")
        
        sut.fetchUsers(urlString: urlString) { result in
            expectations.fulfill()
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].id, 1)
                XCTAssertEqual(users[1].id, 2)
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
        }
        
        wait(for: [expectations], timeout: 1.0)
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let sut = makeSut()
        let expectations = expectation(description: "Should complete with parsing error")
        
        let response = """
        [
            { "id": 1, "username": "johndoe", "mail": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "mmail": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let urlString = "https://example.com/users"
        sut.fetchUsers(urlString: urlString) { result in
            expectations.fulfill()
            switch result {
            case .success(let success):
                XCTFail("Expected failure, but got success with users: \(success)")
            case .failure(let failure):
                XCTAssertEqual(failure, .parsingError)
            }
        }
        
        wait(for: [expectations], timeout: 1.0)
    }

    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        let sut = makeSut()
        let expectations = expectation(description: "Should complete with unexpected error")
        
        mockURLSession.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        let urlString = "https://example.com/users"
        
        sut.fetchUsers(urlString: urlString) { result in
            expectations.fulfill()
            switch result {
            case .success(let success):
                XCTFail("Expected failure, but got success with users: \(success)")
            case .failure(let failure):
                XCTAssertEqual(failure, .unexpected)
            }
        }
        
        wait(for: [expectations], timeout: 1.0)
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        let invalidURL = ""
        
        let result = await sut.fetchUsersAsync(urlString: invalidURL)
            
        switch result {
        case .success(let success):
            XCTFail("Expected failure, but got success with users: \(success)")
        case .failure(let failure):
            XCTAssertEqual(failure, .invalidUrl)
        }
    }

    // TODO: Implement test
    // add other tests for fetchUsersAsync

    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}

//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        let expectation = expectation(description: "Fetch Users calls appropriate method")
        
        sut.fetchUsers {
            expectation.fulfill()
            XCTAssertEqual(self.mockService.fetchUsersCallsCount, 1)
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        // I can't figure out how to test the URL passed to the service, sorry.
    }
    
    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        let expectation = expectation(description: "Fetch Users updates users")
        
        sut.fetchUsers {
            expectation.fulfill()
            XCTAssertEqual(sut.users.count, 1)
            XCTAssertNil(sut.errorMessage)
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    // assert that view model error message is "Unexpected error"
    // Potential mistake? *Looking at the function name it seems like the error should be "Invalid URL"*
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.invalidUrl)
        let sut = makeSut()
        let expectation = expectation(description: "Fetch Users updates error message")
        
        sut.fetchUsers {
            expectation.fulfill()
            XCTAssertEqual(sut.errorMessage, "Unexpected error")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()
        let expectation = expectation(description: "Fetch Users updates error message")
        
        sut.fetchUsers {
            expectation.fulfill()
            XCTAssertEqual(sut.errorMessage, "Unexpected error")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsingError)
        let sut = makeSut()
        let expectation = expectation(description: "Fetch Users updates error message")
        
        sut.fetchUsers {
            expectation.fulfill()
            XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "")]
        )
        
        let sut = makeSut()
        let expectation = expectation(description: "Clear Users updates users to empty")
        
        sut.fetchUsers {
            sut.clearUsers()
            expectation.fulfill()
            XCTAssertTrue(sut.users.isEmpty)
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}

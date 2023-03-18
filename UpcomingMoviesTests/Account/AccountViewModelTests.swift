//
//  AccountViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class AccountViewModelTests: XCTestCase {

    private var mockInteractor: MockAccountInteractor!
    private var viewModelToTest: AccountViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockAccountInteractor()
        viewModelToTest = AccountViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testAuthorizationProcessSuccess() {
        // Arrange
        let permissionURLToTest = URL(string: "http://www.google.com")!
        let expectation = XCTestExpectation(description: "Get permission URL")
        // Act
        viewModelToTest.showAuthPermission.bind { url in
            XCTAssertNotNil(url)
            expectation.fulfill()
        }
        mockInteractor.permissionURLResult = Result.success(permissionURLToTest)
        viewModelToTest.startAuthorizationProcess()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testAuthorizationProcessError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Get permission URL error")
        // Act
        viewModelToTest.didReceiveError.bind {
            expectation.fulfill()
        }
        mockInteractor.permissionURLResult = Result.failure(errorToTest)
        viewModelToTest.startAuthorizationProcess()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInUserSuccess() {
        // Arrange
        let userToTest = User.with()
        let expectation = XCTestExpectation(description: "Sign in user")
        // Act
        viewModelToTest.didUpdateAuthenticationState.bind { state in
            XCTAssertEqual(state, .justSignedIn)
            expectation.fulfill()
        }
        mockInteractor.signInUserResult = Result.success(userToTest)
        viewModelToTest.signInUser()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInUserError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Sign in user error")
        // Act
        viewModelToTest.didReceiveError.bind {
            expectation.fulfill()
        }
        mockInteractor.signInUserResult = Result.failure(errorToTest)
        viewModelToTest.signInUser()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testCurrentUserNotNil() {
        // Arrange
        let userToTest = User.with()
        // Act
        mockInteractor.currentUserResult = userToTest
        let user = viewModelToTest.currentUser()
        // Assert
        XCTAssertNotNil(user)
    }

    func testCurrentUserNil() {
        // Arrange
        let userToTest: UpcomingMoviesDomain.User? = nil
        // Act
        mockInteractor.currentUserResult = userToTest
        let user = viewModelToTest.currentUser()
        // Assert
        XCTAssertNil(user)
    }

    func testIsUserSignedInTrue() {
        // Arrange
        let userToTest = User.with()
        // Act
        mockInteractor.currentUserResult = userToTest
        let isUserSignedIn = viewModelToTest.isUserSignedIn()
        // Assert
        XCTAssertTrue(isUserSignedIn)
    }

    func testIsUserSignedInFalse() {
        // Arrange
        let userToTest: UpcomingMoviesDomain.User? = nil
        // Act
        mockInteractor.currentUserResult = userToTest
        let isUserSignedIn = viewModelToTest.isUserSignedIn()
        // Assert
        XCTAssertFalse(isUserSignedIn)
    }

}

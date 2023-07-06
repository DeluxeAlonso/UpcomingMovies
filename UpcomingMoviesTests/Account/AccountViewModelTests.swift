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

final class AccountViewModelTests: XCTestCase {

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

    func testSignOutUserSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Sign out user")
        // Act
        viewModelToTest.didUpdateAuthenticationState.bind { state in
            XCTAssertEqual(state, .justSignedOut)
            expectation.fulfill()
        }
        mockInteractor.signOutUserResult = Result.success(true)
        viewModelToTest.signOutCurrentUser()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSignOutUserError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Sign out user error")
        // Act
        viewModelToTest.didReceiveError.bind {
            expectation.fulfill()
        }
        mockInteractor.signOutUserResult = Result.failure(errorToTest)
        viewModelToTest.signOutCurrentUser()
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

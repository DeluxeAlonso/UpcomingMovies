//
//  AccountViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain
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

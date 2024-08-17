//
//  AccountViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
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

    func testTitle() {
        // Act
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, "Account")
    }

    func testNavigationItemTitle() {
        // Act
        let title = viewModelToTest.navigationItemTitle
        // Assert
        XCTAssertEqual(title, "Account")
    }

    func testCurrentUserNotNil() {
        // Arrange
        let userToTest = MockUserProtocol()
        // Act
        mockInteractor.currentUserResult = userToTest
        let user = viewModelToTest.currentUser()
        // Assert
        XCTAssertNotNil(user)
    }

    func testCurrentUserNil() {
        // Arrange
        let userToTest: UserProtocol? = nil
        // Act
        mockInteractor.currentUserResult = userToTest
        let user = viewModelToTest.currentUser()
        // Assert
        XCTAssertNil(user)
    }

    func testIsUserSignedInTrue() {
        // Arrange
        let userToTest = MockUserProtocol()
        // Act
        mockInteractor.currentUserResult = userToTest
        let isUserSignedIn = viewModelToTest.isUserSignedIn()
        // Assert
        XCTAssertTrue(isUserSignedIn)
    }

    func testIsUserSignedInFalse() {
        // Arrange
        let userToTest: UserProtocol? = nil
        // Act
        mockInteractor.currentUserResult = userToTest
        let isUserSignedIn = viewModelToTest.isUserSignedIn()
        // Assert
        XCTAssertFalse(isUserSignedIn)
    }

}

//
//  ProfileViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class ProfileViewModelTests: XCTestCase {

    private var mockInteractor: MockProfileInteractor!
    private var mockFactory: MockProfileViewFactory!
    private var viewModelToTest: ProfileViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockProfileInteractor()
        mockFactory = MockProfileViewFactory()
        viewModelToTest = ProfileViewModel(userAccount: MockUserProtocol(),
                                           interactor: mockInteractor,
                                           factory: mockFactory)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        mockFactory = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testGetAccountDetailSuccessInfoReloaded() {
        // Arrange
        let currentUser = MockUserProtocol()
        currentUser.hasUpdatedInfoResult = true
        viewModelToTest = ProfileViewModel(userAccount: currentUser,
                                           interactor: mockInteractor,
                                           factory: mockFactory)

        let userToTest = MockUserProtocol(name: "Alonso")
        let expectation = XCTestExpectation(description: "Reload account info")
        // Act
        viewModelToTest.reloadAccountInfo.bind { _ in
            expectation.fulfill()
        }
        mockInteractor.getAccountDetailResult = .success(userToTest)
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccountDetailSuccessInfoNotReloaded() {
        // Arrange
        let userToTest = MockUserProtocol()
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        // Act
        viewModelToTest.reloadAccountInfo.bind { _ in
            expectation.fulfill()
        }

        mockInteractor.getAccountDetailResult = .success(userToTest)
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccountDetailError() {
        //Arrange
        let errorToTest = TestError()
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        // Act
        viewModelToTest.reloadAccountInfo.bind { _ in
            expectation.fulfill()
        }

        mockInteractor.getAccountDetailResult = Result.failure(errorToTest)
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testCollectionOptionIndex() {
        // Arrange
        let collectionOptionsToTest: [ProfileOptionProtocol] = [ProfileOption.favorites, ProfileOption.watchlist]
        let indexToTest = Int.random(in: 0...collectionOptionsToTest.count - 1)
        // Act
        mockFactory.sections = [.customLists]
        mockFactory.customListsSectionOptions = collectionOptionsToTest
        let firstCollectionOption = viewModelToTest.profileOption(for: 0, at: indexToTest)
        // Assert
        XCTAssertEqual(firstCollectionOption.title, collectionOptionsToTest[indexToTest].title)
    }

    func testCustomListsOptionIndex() {
        // Arrange
        let customListsOptionsToTest: [ProfileOptionProtocol] = [ProfileOption.customLists]
        let indexToTest = Int.random(in: 0...customListsOptionsToTest.count - 1)
        // Act
        mockFactory.sections = [.customLists]
        mockFactory.customListsSectionOptions = customListsOptionsToTest
        let firstCustomListsOption = viewModelToTest.profileOption(for: 0, at: indexToTest)
        // Assert
        XCTAssertEqual(firstCustomListsOption.title, customListsOptionsToTest[indexToTest].title)
    }

    func testSectionIndex() {
        // Arrange
        let sectionsToTest: [ProfileSection] = [.accountInfo, .collections, .customLists, .signOut]
        let indexToTest = Int.random(in: 0...sectionsToTest.count - 1)
        // Act
        mockFactory.sections = sectionsToTest
        let section = viewModelToTest.section(at: indexToTest)
        // Assert
        XCTAssertEqual(section, sectionsToTest[indexToTest])
    }

    func testNumberOfSections() {
        // Arrange
        let sectionsToTest: [ProfileSection] = [.accountInfo, .collections, .customLists, .signOut]
        // Act
        mockFactory.sections = sectionsToTest
        let numberOfSections = viewModelToTest.numberOfSections()
        // Assert
        XCTAssertEqual(numberOfSections, sectionsToTest.count)
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
        let errorToTest = TestError()
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

}

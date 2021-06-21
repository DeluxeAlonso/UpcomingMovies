//
//  ProfileTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class ProfileTests: XCTestCase {
    
    private var mockInteractor: MockProfileInteractor!
    private var mockFactory: MockProfileViewFactory!
    private var viewModelToTest: ProfileViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockProfileInteractor()
        mockFactory = MockProfileViewFactory()
        viewModelToTest = ProfileViewModel(userAccount: User.with(),
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
        let userToTest = User.with(name: "Alonso")
        let expectation = XCTestExpectation(description: "Reload account info")
        // Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        mockInteractor.getAccountDetailResult = .success(userToTest)
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAccountDetailSuccessInfoNotReloaded() {
        // Arrange
        let userToTest = User.with()
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        // Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        mockInteractor.getAccountDetailResult = .success(userToTest)
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAccountDetailError() {
        //Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        // Act
        viewModelToTest.reloadAccountInfo = {
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

}

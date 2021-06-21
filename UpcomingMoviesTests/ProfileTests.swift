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
        mockInteractor.getAccountDetailResult = .success(User.with(name: "Alonso"))
        let expectation = XCTestExpectation(description: "Reload account info")
        // Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAccountDetailSuccessInfoNotReloaded() {
        // Arrange
        mockInteractor.getAccountDetailResult = .success(User.with())
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        // Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAccountDetailError() {
        //Arrange
        mockInteractor.getAccountDetailResult = Result.failure(APIError.badRequest)
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        // Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCollectionOptionIndex() {
        // Arrange
        let collectionOptionsToTest: [ProfileOptionProtocol] = [ProfileOption.favorites, ProfileOption.watchlist]
        let indexToTest = Int.random(in: 0...collectionOptionsToTest.count - 1)
        mockFactory.sections = [.customLists]
        mockFactory.customListsSectionOptions = collectionOptionsToTest
        // Act
        let firstCollectionOption = viewModelToTest.profileOption(for: 0, at: indexToTest)
        // Assert
        XCTAssertEqual(firstCollectionOption.title, collectionOptionsToTest[indexToTest].title)
    }
    
    func testCustomListsOptionIndex() {
        // Arrange
        let customListsOptionsToTest: [ProfileOptionProtocol] = [ProfileOption.customLists]
        let indexToTest = Int.random(in: 0...customListsOptionsToTest.count - 1)
        mockFactory.sections = [.customLists]
        mockFactory.customListsSectionOptions = customListsOptionsToTest
        // Act
        let firstCustomListsOption = viewModelToTest.profileOption(for: 0, at: indexToTest)
        // Assert
        XCTAssertEqual(firstCustomListsOption.title, customListsOptionsToTest[indexToTest].title)
    }
    
    func testSectionIndex() {
        // Arrange
        let sectionsToTest: [ProfileSection] = [.accountInfo, .collections, .customLists, .signOut]
        let indexToTest = Int.random(in: 0...sectionsToTest.count - 1)
        mockFactory.sections = sectionsToTest
        // Act
        let section = viewModelToTest.section(at: indexToTest)
        // Assert
        XCTAssertEqual(section, sectionsToTest[indexToTest])
    }
    
    func testNumberOfSections() {
        // Arrange
        let sectionsToTest: [ProfileSection] = [.accountInfo, .collections, .customLists, .signOut]
        mockFactory.sections = sectionsToTest
        // Act
        let numberOfSections = viewModelToTest.numberOfSections()
        // Assert
        XCTAssertEqual(numberOfSections, sectionsToTest.count)
    }

}

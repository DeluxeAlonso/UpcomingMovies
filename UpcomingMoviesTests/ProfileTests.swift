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
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockProfileInteractor()
        mockFactory = MockProfileViewFactory()
        viewModelToTest = ProfileViewModel(userAccount: User.with(),
                                           interactor: mockInteractor,
                                           factory: mockFactory)
    }
    
    override func tearDown() {
        mockInteractor = nil
        mockFactory = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testGetAccountDetailSuccessInfoReloaded() {
        //Arrange
        mockInteractor.getAccountDetailResult = .success(User.with(name: "Alonso"))
        let expectation = XCTestExpectation(description: "Reload account info")
        //Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAccountDetailSuccessInfoNotReloaded() {
        //Arrange
        mockInteractor.getAccountDetailResult = .success(User.with())
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        //Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetAccountDetailError() {
        //Arrange
        mockInteractor.getAccountDetailResult = Result.failure(APIError.badRequest)
        let expectation = XCTestExpectation(description: "Should not reload account info")
        expectation.isInverted = true
        //Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCollectionOptionIndex() {
        //Arrange
        let collectionOptionsToTest: [ProfileCollectionOption] = [.favorites, .watchlist]
        mockFactory.collectionOptions = collectionOptionsToTest
        //Act
        let firstCollectionOption = viewModelToTest.collectionOption(at: 0)
        //Assert
        XCTAssertEqual(firstCollectionOption.title, collectionOptionsToTest.first?.title)
    }
    
    func testGroupOtionIndex() {
        //Arrange
        let groupOptionsToTest: [ProfileGroupOption] = [.customLists]
        mockFactory.groupOptions = groupOptionsToTest
        //Act
        let firstGroupOption = viewModelToTest.groupOption(at: 0)
        //Assert
        XCTAssertEqual(firstGroupOption.title, groupOptionsToTest.first?.title)
    }
    
    func testSectionIndex() {
        //Arrange
        let sectionsToTest: [ProfileSection] = [.accountInfo, .collections, .groups, .signOut]
        mockFactory.sections = sectionsToTest
        //Act
        let section = viewModelToTest.section(at: 0)
        //Assert
        XCTAssertEqual(section, sectionsToTest.first)
    }
    
    func testNumberOfSections() {
        //Arrange
        let sectionsToTest: [ProfileSection] = [.accountInfo, .collections, .groups, .signOut]
        mockFactory.sections = sectionsToTest
        //Act
        let numberOfSections = viewModelToTest.numberOfSections()
        //Assert
        XCTAssertEqual(numberOfSections, sectionsToTest.count)
    }

}

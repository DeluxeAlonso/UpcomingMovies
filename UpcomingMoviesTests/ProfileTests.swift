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
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testGetAccountDetailInfoReloaded() {
        //Arrange
        mockInteractor.getAccountDetailResult = .success(User.with(name: "Alonso"))
        let expectation = XCTestExpectation(description: "Reload Account Info")
        //Act
        viewModelToTest.reloadAccountInfo = {
            expectation.fulfill()
        }
        viewModelToTest.getAccountDetails()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }

}

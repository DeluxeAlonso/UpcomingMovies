//
//  AccountTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/14/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class AccountTests: XCTestCase {
    
    private var mockInteractor: MockAccountInteractor!
    private var viewModelToTest: AccountViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockAccountInteractor()
        viewModelToTest = AccountViewModel(interactor: mockInteractor)
    }
    
    override func tearDown() {
        mockInteractor = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testAuthorizationProcessSuccess() {
        //Arrange
        mockInteractor.permissionURLResult = Result.success(URL(string: "http://www.google.com")!)
        let expectation = XCTestExpectation(description: "Get permission URL")
        //Act
        viewModelToTest.showAuthPermission.bind { url in
            XCTAssertNotNil(url)
            expectation.fulfill()
        }
        viewModelToTest.startAuthorizationProcess()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAuthorizationProcessError() {
        //Arrange
        mockInteractor.permissionURLResult = Result.failure(APIError.badRequest)
        let expectation = XCTestExpectation(description: "Get permission URL error")
        //Act
        viewModelToTest.didReceiveError = {
            expectation.fulfill()
        }
        viewModelToTest.startAuthorizationProcess()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSignInUserSuccess() {
        //Arrange
        mockInteractor.signInUserResult = Result.success(User.with())
        let expectation = XCTestExpectation(description: "Sign in user")
        //Act
        viewModelToTest.didSignIn = {
            expectation.fulfill()
        }
        viewModelToTest.signInUser()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSignInUserError() {
        //Arrange
        mockInteractor.signInUserResult = Result.failure(APIError.badRequest)
        let expectation = XCTestExpectation(description: "Sign in user error")
        //Act
        viewModelToTest.didReceiveError = {
            expectation.fulfill()
        }
        viewModelToTest.signInUser()
        //Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
}

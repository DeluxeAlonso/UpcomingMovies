//
//  SignInInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class SignInInteractorTests: XCTestCase {

    private var interactor: SignInInteractor!
    private var mockUserUseCase: UserUseCaseProtocolMock!
    private var mockAuthUseCase: AuthUseCaseProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUserUseCase = UserUseCaseProtocolMock()
        mockAuthUseCase = AuthUseCaseProtocolMock()
        interactor = SignInInteractor(authUseCase: mockAuthUseCase, userUseCase: mockUserUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockUserUseCase = nil
        mockAuthUseCase = nil
        try super.tearDownWithError()
    }

    func testGetAuthPermissionURL() {
        // Act
        interactor.getAuthPermissionURL(completion: { _ in })
        // Assert
        XCTAssertEqual(mockAuthUseCase.getAuthURLCallCount, 1)
    }

    func testSignInUserSuccess() {
        // Arrange
        mockAuthUseCase.signInUserResult = .success(.with())
        // Act
        interactor.signInUser(completion: { _ in })
        // Assert
        XCTAssertEqual(mockAuthUseCase.signInUserCallCount, 1)
        XCTAssertEqual(mockUserUseCase.saveUserCallCount, 1)
    }

    func testSignInUserError() {
        // Arrange
        mockAuthUseCase.signInUserResult = .failure(TestError())
        // Act
        interactor.signInUser(completion: { _ in })
        // Assert
        XCTAssertEqual(mockAuthUseCase.signInUserCallCount, 1)
        XCTAssertEqual(mockUserUseCase.saveUserCallCount, 0)
    }

}

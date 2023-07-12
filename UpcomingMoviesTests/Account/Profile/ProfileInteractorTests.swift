//
//  ProfileInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 12/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

final class ProfileInteractorTests: XCTestCase {

    private var interactor: ProfileInteractor!
    private var mockUserUseCase: UserUseCaseProtocolMock!
    private var mockAuthUseCase: AuthUseCaseProtocolMock!
    private var mockAccountUseCase: AccountUseCaseProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUserUseCase = UserUseCaseProtocolMock()
        mockAuthUseCase = AuthUseCaseProtocolMock()
        interactor = ProfileInteractor(userUseCase: mockUserUseCase,
                                       authUseCase: mockAuthUseCase,
                                       accountUseCase: mockAccountUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockUserUseCase = nil
        mockAuthUseCase = nil
        mockAccountUseCase = nil
        try super.tearDownWithError()
    }

    func testGetAccountDetailSuccess() {
        // Arrange
        mockAccountUseCase.getAccountDetailResult = .success(.with())
        // Act
        interactor.getAccountDetail(completion: { _ in })
        // Assert
        XCTAssertEqual(mockUserUseCase.saveUserCallCount, 1)
    }

}

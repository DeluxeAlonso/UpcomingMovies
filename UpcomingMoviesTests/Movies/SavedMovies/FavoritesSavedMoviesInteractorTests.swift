//
//  FavoritesSavedMoviesInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 24/08/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class FavoritesSavedMoviesInteractorTests: XCTestCase {

    private var interactor: FavoritesSavedMoviesInteractor!
    private var accountUseCase: AccountUseCaseProtocolMock! = AccountUseCaseProtocolMock()

    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = FavoritesSavedMoviesInteractor(accountUseCase: accountUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        accountUseCase = nil
        try super.tearDownWithError()
    }

    func testGetFavoriteListCalled() {
        // Arrange
        let moviesToTest = [Movie.with(id: 1)]
        accountUseCase.getFavoriteListResult = .success(moviesToTest)

        let expectation = XCTestExpectation(description: "Should get saved movies")
        // Act
        interactor.getSavedMovies(page: 1) { movies in
            guard let movies = movies.wrappedValue else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies.count, moviesToTest.count)
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountUseCase.getFavoriteListCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

}

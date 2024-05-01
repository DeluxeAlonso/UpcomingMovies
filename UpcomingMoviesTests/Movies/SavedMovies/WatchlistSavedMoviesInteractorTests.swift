//
//  WatchlistSavedMoviesInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 27/08/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class WatchlistSavedMoviesInteractorTests: XCTestCase {

    private var interactor: WatchlistSavedMoviesInteractor!
    private var accountUseCase: AccountUseCaseProtocolMock! = AccountUseCaseProtocolMock()

    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = WatchlistSavedMoviesInteractor(accountUseCase: accountUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        accountUseCase = nil
        try super.tearDownWithError()
    }

    func testGetWatchlistCalled() {
        // Arrange
        let moviesToTest = [Movie.with(id: 1)]
        accountUseCase.getWatchlistResult = .success(moviesToTest)

        let expectation = XCTestExpectation(description: "Should get saved movies")
        // Act
        interactor.getSavedMovies(page: 1) { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies.count, moviesToTest.count)
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountUseCase.getWatchlistCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

}

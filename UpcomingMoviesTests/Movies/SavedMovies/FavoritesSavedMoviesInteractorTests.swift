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

class FavoritesSavedMoviesInteractorTests: XCTestCase {

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
        // Act
        interactor.getSavedMovies(page: 1) { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies, moviesToTest)
        }
        // Assert
        XCTAssertEqual(accountUseCase.getFavoriteListCallCount, 1)
    }

}

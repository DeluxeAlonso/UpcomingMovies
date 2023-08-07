//
//  MovieCreditsInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 3/06/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MovieCreditsInteractorTests: XCTestCase {

    private var interactor: MovieCreditsInteractor!
    private var mockMovieUseCase: MovieUseCaseProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMovieUseCase = MovieUseCaseProtocolMock()
        interactor = MovieCreditsInteractor(movieUseCase: mockMovieUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockMovieUseCase = nil
        try super.tearDownWithError()
    }

    func testGetMovieCreditsCalled() {
        // Act
        interactor.getMovieCredits(for: 1, page: 1, completion: { _ in })
        // Assert
        XCTAssertEqual(mockMovieUseCase.getMovieCreditsCallCount, 1)
    }

}

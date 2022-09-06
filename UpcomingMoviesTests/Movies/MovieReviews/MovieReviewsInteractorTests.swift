//
//  MovieReviewsInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 4/06/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MovieReviewsInteractorTests: XCTestCase {

    private var interactor: MovieReviewsInteractor!
    private var mockMovieUseCase: UpcomingMoviesDomain.MovieUseCaseProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMovieUseCase = MovieUseCaseProtocolMock()
        interactor = MovieReviewsInteractor(movieUseCase: mockMovieUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockMovieUseCase = nil
        try super.tearDownWithError()
    }

    func testGetMovieReviewssCalled() {
        // Arrange
        let reviewToTest = [Review.with()]
        mockMovieUseCase.getMovieReviewsResult = .success(reviewToTest)
        // Act
        interactor.getMovieReviews(for: 1, page: 1, completion: { reviews in
            
        })
        // Assert
        XCTAssertEqual(mockMovieUseCase.getMovieReviewsCallCount, 1)
    }

}

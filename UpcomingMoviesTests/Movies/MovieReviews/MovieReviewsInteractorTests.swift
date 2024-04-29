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

final class MovieReviewsInteractorTests: XCTestCase {

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

    func testGetMovieReviewsCalled() {
        // Arrange
        let reviewToTest = [Review.with()]
        mockMovieUseCase.getMovieReviewsResult = .success(reviewToTest)

        let expectation = XCTestExpectation(description: "Should get reviews")
        // Act
        interactor.getMovieReviews(for: 1, page: 1, completion: { reviews in
            guard let reviews = try? reviews.get() else {
                XCTFail("No valid reviews")
                return
            }
            XCTAssertEqual(reviews.map { $0.id }, reviewToTest.map { $0.id })
            expectation.fulfill()
        })
        // Assert
        XCTAssertEqual(mockMovieUseCase.getMovieReviewsCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

}

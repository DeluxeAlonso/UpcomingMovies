//
//  MovieReviewsViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieReviewsViewModelTests: XCTestCase {

    typealias MovieReviewsState = SimpleViewState<ReviewProtocol>

    private var mockInteractor: MockMovieReviewsInteractor!
    private var viewModelToTest: MovieReviewsViewModelProtocol!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMovieReviewsInteractor()
        viewModelToTest = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1",
                                                interactor: mockInteractor)
    }

    override func tearDown() {
        mockInteractor = nil
        viewModelToTest = nil
        super.tearDown()
    }

    func testMovieReviewsTitle() {
        // Act
        let title = viewModelToTest.movieTitle
        // Assert
        XCTAssertEqual(title, "Movie 1")
    }

    func testEmptyReviewResultsTitle() {
        // Act
        let emptyReviewResultsTitle = viewModelToTest.emptyReviewResultsTitle
        // Assert
        XCTAssertEqual(emptyReviewResultsTitle, "There are no reviews to show right now.")
    }

    func testGetReviewsEmpty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get empty state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .empty)
            expectation.fulfill()
        }
        mockInteractor.getMovieReviewsResult = Result.success([])
        viewModelToTest.getMovieReviews()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetReviewsPopulated() {
        // Arrange
        let reviewsToTest = [MockReviewProtocol(id: "1"), MockReviewProtocol(id: "2")]
        let expectation = XCTestExpectation(description: "Should get populated state")
        var statesToReceive: [MovieReviewsState] = [.paging(reviewsToTest, next: 2), .populated(reviewsToTest)]
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, statesToReceive.removeFirst())
            expectation.fulfill()
        }
        mockInteractor.getMovieReviewsResult = Result.success(reviewsToTest)
        viewModelToTest.getMovieReviews()
        mockInteractor.getMovieReviewsResult = Result.success([])
        viewModelToTest.getMovieReviews()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetReviewsPaging() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging([MockReviewProtocol(id: "1"), MockReviewProtocol(id: "2")], next: 2))
            expectation.fulfill()
        }
        mockInteractor.getMovieReviewsResult = Result.success([MockReviewProtocol(id: "1"), MockReviewProtocol(id: "2")])
        viewModelToTest.getMovieReviews()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetReviewsError() {
        // Arrange
        let errorToTest = TestError()
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.getMovieReviewsResult = Result.failure(errorToTest)
        viewModelToTest.getMovieReviews()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testRefreshReviews() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging([MockReviewProtocol(id: "1"), MockReviewProtocol(id: "2")], next: 2))
            expectation.fulfill()
        }
        mockInteractor.getMovieReviewsResult = Result.success([MockReviewProtocol(id: "1"), MockReviewProtocol(id: "2")])
        viewModelToTest.refreshMovieReviews()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}

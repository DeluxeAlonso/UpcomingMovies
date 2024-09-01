//
//  MovieVideosViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso Alvarez on 2/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieVideosViewModelTests: XCTestCase {

    private var mockInteractor: MockMovieVideosInteractor!
    private var viewModelToTest: MovieVideosViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockMovieVideosInteractor()
        viewModelToTest = MovieVideosViewModel(movieId: 1,
                                               movieTitle: "Movie Test",
                                               interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testMovieVideosTitle() {
        // Act
        let title = viewModelToTest.movieTitle
        // Assert
        XCTAssertEqual(title, "Movie Test")
    }

    func testEmptyVideoResultsTitle() {
        // Act
        let emptyVideoResultsTitle = viewModelToTest.emptyVideoResultsTitle
        // Assert
        XCTAssertEqual(emptyVideoResultsTitle, "There are no trailers to show right now.")
    }

    func testGetVideosPopulated() {
        // Arrange
        let videostoTest = [MockVideoProtocol(id: "1"), MockVideoProtocol(id: "2")]
        let expectation = XCTestExpectation(description: "Should get populated state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .populated(videostoTest))
            expectation.fulfill()
        }
        mockInteractor.getMovieVideosResult = Result.success(videostoTest)
        viewModelToTest.getMovieVideos(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetVideosEmpty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get empty state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .empty)
            expectation.fulfill()
        }
        mockInteractor.getMovieVideosResult = Result.success([])
        viewModelToTest.getMovieVideos(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetVideosError() {
        // Arrange
        let errorToTest = TestError()
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.getMovieVideosResult = Result.failure(errorToTest)
        viewModelToTest.getMovieVideos(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}

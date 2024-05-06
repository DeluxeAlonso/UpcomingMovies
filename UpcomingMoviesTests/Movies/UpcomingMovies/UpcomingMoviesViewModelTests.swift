//
//  UpcomingMoviesViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class UpcomingMoviesViewModelTests: XCTestCase {

    typealias MoviesViewState = SimpleViewState<MovieProtocol>

    private var mockInteractor: MockUpcomingMoviesInteractor!
    private var mockFactory = MockUpcomingMoviesFactory()
    private var mockUserPreferencesHandler = MockUserPreferencesHandler()
    private var viewModelToTest: UpcomingMoviesViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockUpcomingMoviesInteractor()
        viewModelToTest = UpcomingMoviesViewModel(interactor: mockInteractor,
                                                  factory: mockFactory,
                                                  userPreferencesHandler: mockUserPreferencesHandler)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testGetMoviesEmpty() {
        // Arrange
        let moviesToTest: [MovieProtocol] = []
        let expectation = XCTestExpectation(description: "Should get empty state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertTrue(state == .empty)
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.success(moviesToTest)
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesPopulated() {
        // Arrange
        let moviesToTest = [MockMovieProtocol(id: 1), MockMovieProtocol(id: 2)]
        var statesToReceive: [MoviesViewState] = [.paging(moviesToTest, next: 2), .populated(moviesToTest)]

        let expectation = XCTestExpectation(description: "Should get populated state after a paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, statesToReceive.removeFirst())
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.success(moviesToTest)
        viewModelToTest.getMovies()
        mockInteractor.upcomingMovies = Result.success([])
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesPaging() {
        // Arrange
        let moviestoTest = [MockMovieProtocol(id: 1), MockMovieProtocol(id: 2)]
        let expectation = XCTestExpectation(description: "Should get paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging(moviestoTest, next: 2))
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.success(moviestoTest)
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesError() {
        // Arrange
        let errorToTest = TestError()
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertTrue(state == .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.failure(errorToTest)
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testUpcomingMovieCellPosterURL() {
        // Arrange
        let cellViewModel = UpcomingMovieCellViewModel(MockMovieProtocol(posterURL: URL(string: "https://image.tmdb.org/t/p/w185/poster.jpg")))
        // Act
        let posterURL = cellViewModel.posterURL
        // Assert
        XCTAssertEqual(posterURL, URL(string: "https://image.tmdb.org/t/p/w185/poster.jpg"))
    }

    func testUpcomingMovieCellBackdropURL() {
        // Arrange
        let cellViewModel = UpcomingMovieCellViewModel(MockMovieProtocol(backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/backdrop.jpg")))
        // Act
        let backdropURL = cellViewModel.backdropURL
        // Assert
        XCTAssertEqual(backdropURL, URL(string: "https://image.tmdb.org/t/p/w500/backdrop.jpg"))
    }

}

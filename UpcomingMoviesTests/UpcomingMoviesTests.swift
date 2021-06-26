//
//  UpcomingMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class UpcomingMoviesTests: XCTestCase {

    typealias MoviesViewState = SimpleViewState<UpcomingMoviesDomain.Movie>
    
    private var mockInteractor: MockUpcomingMoviesInteractor!
    private var viewModelToTest: UpcomingMoviesViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockUpcomingMoviesInteractor()
        viewModelToTest = UpcomingMoviesViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }
    
    func testGetMoviesEmpty() {
        // Arrange
        let moviesToTest: [UpcomingMoviesDomain.Movie] = []
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
        let moviesToTest = [Movie.with(id: 1), Movie.with(id: 2)]
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
        let moviestoTest = [Movie.with(id: 1), Movie.with(id: 2)]
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
        let errorToTest = APIError.badRequest
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
        let cellViewModel = UpcomingMovieCellViewModel(Movie.with())
        // Act
        let posterURL = cellViewModel.posterURL
        // Assert
        XCTAssertEqual(posterURL, URL(string: "https://image.tmdb.org/t/p/w185/poster.jpg"))
    }
    
    func testUpcomingMovieCellBackdropURL() {
        // Arrange
        let cellViewModel = UpcomingMovieCellViewModel(Movie.with())
        // Act
        let backdropURL = cellViewModel.backdropURL
        // Assert
        XCTAssertEqual(backdropURL, URL(string: "https://image.tmdb.org/t/p/w500/backdrop.jpg"))
    }

}

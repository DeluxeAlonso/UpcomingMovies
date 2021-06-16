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

    override func setUp() {
        super.setUp()
        mockInteractor = MockUpcomingMoviesInteractor()
        viewModelToTest = UpcomingMoviesViewModel(interactor: mockInteractor)
    }

    override func tearDown() {
        mockInteractor = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testGetMoviesEmpty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get empty state")
        viewModelToTest.viewState.bind { state in
            XCTAssertTrue(state == .empty)
            expectation.fulfill()
        }
        // Act
        mockInteractor.upcomingMovies = Result.success([])
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetMoviesPopulated() {
        // Arrange
        let moviesToEvaluate = [Movie.with(id: 1), Movie.with(id: 2)]
        var statesToReceive: [MoviesViewState] = [.paging(moviesToEvaluate, next: 2), .populated(moviesToEvaluate)]

        let expectation = XCTestExpectation(description: "Should get populated state after recaiving a paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, statesToReceive.removeFirst())
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.success(moviesToEvaluate)
        viewModelToTest.getMovies()
        mockInteractor.upcomingMovies = Result.success([])
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetMoviesPaging() {
        // Arrange
        let moviesToEvaluate = [Movie.with(id: 1), Movie.with(id: 2)]
        let expectation = XCTestExpectation(description: "Should get paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging(moviesToEvaluate, next: 2))
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.success(moviesToEvaluate)
        viewModelToTest.getMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetMoviesError() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertTrue(state == .error(APIError.badRequest))
            expectation.fulfill()
        }
        mockInteractor.upcomingMovies = Result.failure(APIError.badRequest)
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

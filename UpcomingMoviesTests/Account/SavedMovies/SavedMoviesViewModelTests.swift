//
//  SavedMoviesViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class SavedMoviesViewModelTests: XCTestCase {

    private var mockInteractor: MockSavedMoviesInteractor!
    private var viewModelToTest: SavedMoviesViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockSavedMoviesInteractor()
        viewModelToTest = SavedMoviesViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testSavedMoviesTitle() {
        // Arrange
        viewModelToTest.displayTitle = "Test title"
        // Act
        let title = viewModelToTest.displayTitle
        // Assert
        XCTAssertEqual(title, "Test title")
    }

    func testGetCollectionListPopulated() {
        // Arrange
        let moviestoTest = [Movie.with(id: 1), Movie.with(id: 2)]
        var statesToReceive: [SimpleViewState<UpcomingMoviesDomain.Movie>] = [.paging(moviestoTest, next: 2), .populated(moviestoTest)]

        let expectation = XCTestExpectation(description: "Should get populated state after a paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, statesToReceive.removeFirst())
            expectation.fulfill()
        }
        mockInteractor.getSavedMoviesResult = Result.success(moviestoTest)
        viewModelToTest.getCollectionList()
        mockInteractor.getSavedMoviesResult = Result.success([])
        viewModelToTest.getCollectionList()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCollectionListPaging() {
        // Arrange
        let moviesToTest = [Movie.with(id: 1), Movie.with(id: 2)]
        let expectation = XCTestExpectation(description: "Should get paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging(moviesToTest, next: 2))
            expectation.fulfill()
        }
        mockInteractor.getSavedMoviesResult = Result.success(moviesToTest)
        viewModelToTest.getCollectionList()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCollectionListEmpty() {
        // Arrange
        let moviesToTest: [UpcomingMoviesDomain.Movie] = []
        let expectation = XCTestExpectation(description: "Should get empty state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .empty)
            expectation.fulfill()
        }
        mockInteractor.getSavedMoviesResult = Result.success(moviesToTest)
        viewModelToTest.getCollectionList()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCollectionListError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.getSavedMoviesResult = Result.failure(APIError.badRequest)
        viewModelToTest.getCollectionList()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testMovieCellsCount() {
        // Arrange
        let moviesToTest = [Movie.with(id: 1), Movie.with(id: 2)]
        // Act
        mockInteractor.getSavedMoviesResult = Result.success(moviesToTest)
        viewModelToTest.getCollectionList()
        let cellsCount = viewModelToTest.movieCells.count
        // Assert
        XCTAssertEqual(cellsCount, moviesToTest.count)
    }

    func testMovieCellsZeroCount() {
        // Arrange
        let moviesToTest: [UpcomingMoviesDomain.Movie] = []
        // Act
        mockInteractor.getSavedMoviesResult = Result.success(moviesToTest)
        viewModelToTest.getCollectionList()
        let cellsCount = viewModelToTest.movieCells.count
        // Assert
        XCTAssertEqual(cellsCount, .zero)
    }

    func testMovieIndex() {
        // Arrange
        let moviesToTest = [Movie.with(id: 1), Movie.with(id: 2)]
        let indexToTest = Int.random(in: 0...moviesToTest.count - 1)
        // Act
        mockInteractor.getSavedMoviesResult = Result.success(moviesToTest)
        viewModelToTest.getCollectionList()
        let movie = viewModelToTest.movie(at: indexToTest)
        // Assert
        XCTAssertEqual(movie, moviesToTest[indexToTest])
    }

}

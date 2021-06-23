//
//  SavedMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class SavedMoviesTests: XCTestCase {
    
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

        // Act
        mockInteractor.getSavedMoviesResult = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        viewModelToTest.getCollectionList()
        mockInteractor.getSavedMoviesResult = Result.success([])
        viewModelToTest.getCollectionList()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Movie.with(id: 1), Movie.with(id: 2)]))
    }
    
    func testGetCollectionListPaging() {
        // Arrange

        // Act
        mockInteractor.getSavedMoviesResult = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        viewModelToTest.getCollectionList()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value,
                       .paging([Movie.with(id: 1), Movie.with(id: 2)], next: 2))
    }
    
    func testGetCollectionListEmpty() {
        // Arrange

        // Act
        mockInteractor.getSavedMoviesResult = Result.success([])
        viewModelToTest.getCollectionList()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetCollectionListError() {
        // Arrange

        // Act
        mockInteractor.getSavedMoviesResult = Result.failure(APIError.badRequest)
        viewModelToTest.getCollectionList()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
    func testMovieCellsCount() {
        // Arrange
        let movies = [Movie.with(id: 1), Movie.with(id: 2)]
        // Act
        mockInteractor.getSavedMoviesResult = Result.success(movies)
        viewModelToTest.getCollectionList()
        let cellsCount = viewModelToTest.movieCells.count
        // Assert
        XCTAssertEqual(cellsCount, movies.count)
    }
    
    func testMovieCellsZeroCount() {
        // Arrange

        // Act
        mockInteractor.getSavedMoviesResult = Result.success([])
        viewModelToTest.getCollectionList()
        let cellsCount = viewModelToTest.movieCells.count
        // Assert
        XCTAssertEqual(cellsCount, .zero)
    }
    
    func testMovieIndex() {
        // Arrange
        let movies = [Movie.with(id: 1), Movie.with(id: 2)]
        let indexToTest = Int.random(in: 0...movies.count - 1)
        // Act
        mockInteractor.getSavedMoviesResult = Result.success(movies)
        viewModelToTest.getCollectionList()
        let movie = viewModelToTest.movie(at: indexToTest)
        // Assert
        XCTAssertEqual(movie, movies[indexToTest])
    }

}

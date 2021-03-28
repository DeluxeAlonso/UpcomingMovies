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
    private var mockViewStateHandler: MockViewStateHandler!
    private var viewModelToTest: SavedMoviesViewModelProtocol!

    override func setUp() {
        super.setUp()
        mockInteractor = MockSavedMoviesInteractor()
        mockViewStateHandler = MockViewStateHandler()
        viewModelToTest = SavedMoviesViewModel(interactor: mockInteractor,
                                               viewStateHandler: mockViewStateHandler)
    }
    
    override func tearDown() {
        mockInteractor = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testSavedMoviesTitle() {
        //Arrange
        viewModelToTest.displayTitle = "Test title"
        //Act
        let title = viewModelToTest.displayTitle
        //Assert
        XCTAssertEqual(title, "Test title")
    }
    
    func testGetCollectionListPopulated() {
        //Arrange
        mockInteractor.getSavedMoviesResult = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        //Act
        viewModelToTest.getCollectionList()
        mockInteractor.getSavedMoviesResult = Result.success([])
        viewModelToTest.getCollectionList()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Movie.with(id: 1), Movie.with(id: 2)]))
    }
    
    func testGetCollectionListPaging() {
        //Arrange
        mockInteractor.getSavedMoviesResult = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        //Act
        viewModelToTest.getCollectionList()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value,
                       .paging([Movie.with(id: 1), Movie.with(id: 2)], next: 2))
    }
    
    func testGetCollectionListEmpty() {
        //Arrange
        mockInteractor.getSavedMoviesResult = Result.success([])
        //Act
        viewModelToTest.getCollectionList()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetCollectionListError() {
        //Arrange
        mockInteractor.getSavedMoviesResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getCollectionList()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
    func testMovieCellsCount() {
        //Arrange
        let movies = [Movie.with(id: 1), Movie.with(id: 2)]
        mockInteractor.getSavedMoviesResult = Result.success(movies)
        //Act
        viewModelToTest.getCollectionList()
        let cellsCount = viewModelToTest.movieCells.count
        //Assert
        XCTAssertEqual(cellsCount, movies.count)
    }
    
    func testMovieCellsZeroCount() {
        //Arrange
        mockInteractor.getSavedMoviesResult = Result.success([])
        //Act
        viewModelToTest.getCollectionList()
        let cellsCount = viewModelToTest.movieCells.count
        //Assert
        XCTAssertEqual(cellsCount, .zero)
    }
    
    func testMovieIndex() {
        //Arrange
        let movies = [Movie.with(id: 1), Movie.with(id: 2)]
        mockInteractor.getSavedMoviesResult = Result.success(movies)
        let indexToTest = Int.random(in: 0...movies.count - 1)
        //Act
        viewModelToTest.getCollectionList()
        let movie = viewModelToTest.movie(at: indexToTest)
        //Assert
        XCTAssertEqual(movie, movies[indexToTest])
    }

}

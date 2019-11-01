//
//  UpcomingMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import Domain

class UpcomingMoviesTests: XCTestCase {
    
    var viewModelToTest: UpcomingMoviesViewModel!
    var upcomingMovieCellViewModelToTest: UpcomingMovieCellViewModel!

    override func setUp() {
        super.setUp()
        viewModelToTest = UpcomingMoviesViewModel(useCaseProvider: InjectionFactory.useCaseProvider())
        upcomingMovieCellViewModelToTest = UpcomingMovieCellViewModel(Movie.with())
    }

    override func tearDown() {
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testGestMoviesPopulated() {
        //Arrange
        let movieResult = MovieResult(results: [Movie.with(id: 1), Movie.with(id: 2)],
                                      currentPage: 1, totalPages: 1)
        let mockupClient = MockMovieClient()
        mockupClient.getMovieResult = Result.success(movieResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Movie.with(id: 1), Movie.with(id: 2)]))
    }
    
    func testGetMoviesEmpty() {
        //Arrange
        let movieResult = MovieResult(results: [],
                                      currentPage: 1, totalPages: 1)
        let mockupClient = MockMovieClient()
        mockupClient.getMovieResult = Result.success(movieResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetMoviesPaging() {
        //Arrange
        let movieResult = MovieResult(results: [Movie.with(id: 1), Movie.with(id: 2)],
                                      currentPage: 1, totalPages: 2)
        let mockupClient = MockMovieClient()
        mockupClient.getMovieResult = Result.success(movieResult)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value,
                       .paging([Movie.with(id: 1), Movie.with(id: 2)], next: 2))
    }
    
    func testGetMoviesError() {
        //Arrange
        let mockupClient = MockMovieClient()
        mockupClient.getMovieResult = Result.failure(APIError.badRequest)
        viewModelToTest.movieClient = mockupClient
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
    func testSelectedMovieCell() {
        //Arrange
        let moviesToTest = [Movie.with(id: 1), Movie.with(id: 2)]
        viewModelToTest.viewState.value = .populated(moviesToTest)
        //Act
        viewModelToTest.setSelectedMovie(at: 0)
        let selectedMovieCell = viewModelToTest.selectedMovieCell
        let movieFullPosterPath = selectedMovieCell?.posterURL
        //Assert
        XCTAssertEqual(movieFullPosterPath, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }
    
    func testUpcomingMovieCellPosterPath() {
        //Act
        let posterPath = upcomingMovieCellViewModelToTest.posterURL
        //Assert
        XCTAssertEqual(posterPath, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }

}

private final class MockMovieClient: MovieClient {
    
    var getMovieResult: Result<MovieResult?, APIError>?
    
    override func getMovies(page: Int, filter: MovieListFilter, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        completion(getMovieResult!)
    }
    
}

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
    
    private var useCaseProvider: MockUseCaseProvider!
    private var movieUseCase: MockMovieUseCase!
    
    var upcomingMovieCellViewModelToTest: UpcomingMovieCellViewModel!

    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        
        upcomingMovieCellViewModelToTest = UpcomingMovieCellViewModel(Movie.with())
    }

    override func tearDown() {
        useCaseProvider = nil
        movieUseCase = nil
        upcomingMovieCellViewModelToTest = nil
        super.tearDown()
    }
    
    func testGetMoviesEmpty() {
        //Arrange
        movieUseCase.movies = Result.success([])
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .empty)
    }
    
    func testGetMoviesPaging() {
        //Arrange
        movieUseCase.movies = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value,
                       .paging([Movie.with(id: 1), Movie.with(id: 2)], next: 2))
    }
    
    func testGetMoviesError() {
        //Arrange
        movieUseCase.movies = Result.failure(APIError.badRequest)
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .error(APIError.badRequest))
    }
    
    func testSelectedMovieCell() {
        //Arrange
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider)
        viewModel.viewState.value = .populated([Movie.with(id: 1), Movie.with(id: 2)])
        //Act
        viewModel.setSelectedMovie(at: 0)
        let selectedMovieCell = viewModel.selectedMovieCell
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

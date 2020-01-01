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
        viewModel.viewState.value = .populated([Movie.with(id: 1, title: "M1"), Movie.with(id: 2, title: "M2")])
        //Act
        viewModel.setSelectedMovie(at: 1)
        let selectedMovieCell = viewModel.selectedMovieCell
        let movieTitle = selectedMovieCell?.title
        //Assert
        XCTAssertEqual(movieTitle, "M2")
    }
    
    func testUpcomingMovieCellPosterURL() {
        //Act
        let posterURL = upcomingMovieCellViewModelToTest.posterURL
        //Assert
        XCTAssertEqual(posterURL, URL(string: "https://image.tmdb.org/t/p/w185/poster.jpg"))
    }
    
    func testUpcomingMovieCellBackdropURL() {
        //Act
        let backdropURL = upcomingMovieCellViewModelToTest.backdropURL
        //Assert
        XCTAssertEqual(backdropURL, URL(string: "https://image.tmdb.org/t/p/w185/backdrop.jpg"))
    }

}

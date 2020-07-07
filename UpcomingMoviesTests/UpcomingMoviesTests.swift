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
        movieUseCase.upcomingMovies = Result.success([])
        let contentHandler = UpcomingMoviesContentHandler(movieUseCase: movieUseCase)
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider, contentHandler: contentHandler)
        //Act
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .empty)
    }
    
    func testGetMoviesPopulated() {
        //Arrange
        movieUseCase.upcomingMovies = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        let contentHandler = UpcomingMoviesContentHandler(movieUseCase: movieUseCase)
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider,
                                                contentHandler: contentHandler)
        //Act
        viewModel.getMovies()
        movieUseCase.upcomingMovies = Result.success([])
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .populated([Movie.with(id: 1), Movie.with(id: 2)]))
    }
    
    func testGetMoviesPaging() {
        //Arrange
        movieUseCase.upcomingMovies = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        let contentHandler = UpcomingMoviesContentHandler(movieUseCase: movieUseCase)
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider,
                                                contentHandler: contentHandler)
        //Act
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value,
                       .paging([Movie.with(id: 1), Movie.with(id: 2)], next: 2))
    }
    
    func testGetMoviesError() {
        //Arrange
        movieUseCase.upcomingMovies = Result.failure(APIError.badRequest)
        let contentHandler = UpcomingMoviesContentHandler(movieUseCase: movieUseCase)
        let viewModel = UpcomingMoviesViewModel(useCaseProvider: useCaseProvider,
                                                contentHandler: contentHandler)
        //Act
        viewModel.getMovies()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .error(APIError.badRequest))
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
        XCTAssertEqual(backdropURL, URL(string: "https://image.tmdb.org/t/p/w500/backdrop.jpg"))
    }

}

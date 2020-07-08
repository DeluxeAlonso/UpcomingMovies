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
    
    private var movieUseCase: MockMovieUseCase!
    private var viewModelToTest: UpcomingMoviesViewModelProtocol!

    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        let useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        let interactor = UpcomingMoviesInteractor(useCaseProvider: useCaseProvider)
        viewModelToTest = UpcomingMoviesViewModel(interactor: interactor)
    }

    override func tearDown() {
        movieUseCase = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testGetMoviesEmpty() {
        //Arrange
        movieUseCase.upcomingMovies = Result.success([])
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetMoviesPopulated() {
        //Arrange
        movieUseCase.upcomingMovies = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        //Act
        viewModelToTest.getMovies()
        movieUseCase.upcomingMovies = Result.success([])
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Movie.with(id: 1), Movie.with(id: 2)]))
    }
    
    func testGetMoviesPaging() {
        //Arrange
        movieUseCase.upcomingMovies = Result.success([Movie.with(id: 1), Movie.with(id: 2)])
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value,
                       .paging([Movie.with(id: 1), Movie.with(id: 2)], next: 2))
    }
    
    func testGetMoviesError() {
        //Arrange
        movieUseCase.upcomingMovies = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getMovies()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
    func testUpcomingMovieCellPosterURL() {
        //Arrange
        let cellViewModel = UpcomingMovieCellViewModel(Movie.with())
        //Act
        let posterURL = cellViewModel.posterURL
        //Assert
        XCTAssertEqual(posterURL, URL(string: "https://image.tmdb.org/t/p/w185/poster.jpg"))
    }
    
    func testUpcomingMovieCellBackdropURL() {
        //Arrange
        let cellViewModel = UpcomingMovieCellViewModel(Movie.with())
        //Act
        let backdropURL = cellViewModel.backdropURL
        //Assert
        XCTAssertEqual(backdropURL, URL(string: "https://image.tmdb.org/t/p/w500/backdrop.jpg"))
    }

}

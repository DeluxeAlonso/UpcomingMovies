//
//  MovieCreditsTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class MovieCreditsTests: XCTestCase {

    private var movieUseCase: MockMovieUseCase!
    private var viewModelToTest: MovieCreditsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        
        let useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        
        viewModelToTest = MovieCreditsViewModel(movieId: 1,
                                                movieTitle: "Movie 1",
                                                useCaseProvider: useCaseProvider)
    }
    
    override func tearDown() {
        movieUseCase = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testMovieCreditsTitle() {
        //Act
        let title = viewModelToTest.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie 1")
    }
    
    func testGetMovieCreditsEmpty() {
        //Arrange
        movieUseCase.credits = Result.success(MovieCredits.with())
        //Act
        viewModelToTest.getMovieCredits(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetMovieCreditsPopulated() {
        //Arrange
        let crew = MovieCredits(cast: [Cast.with()], crew: [Crew.with()])
        movieUseCase.credits = Result.success(crew)
        //Act
        viewModelToTest.getMovieCredits(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Cast.with()], [Crew.with()]))
    }
    
    func testGetMovieCreditsError() {
        //Arrange
        movieUseCase.credits = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getMovieCredits(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
}

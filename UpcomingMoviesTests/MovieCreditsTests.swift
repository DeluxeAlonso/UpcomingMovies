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

    private var mockInteractor: MockMovieCreditsInteractor!
    private var mockFactory: MockMovieCreditsFactory!
    private var viewModelToTest: MovieCreditsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockMovieCreditsInteractor()
        mockFactory = MockMovieCreditsFactory()
        
        viewModelToTest = MovieCreditsViewModel(movieId: 1, movieTitle: "Movie 1",
                                                interactor: mockInteractor, factory: mockFactory)
    }
    
    override func tearDown() {
        mockInteractor = nil
        mockFactory = nil
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
        mockInteractor.getMovieCreditsResult = Result.success(MovieCredits.withEmptyValues())
        //Act
        viewModelToTest.getMovieCredits(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetMovieCreditsPopulated() {
        //Arrange
        mockInteractor.getMovieCreditsResult = Result.success(MovieCredits.with())
        //Act
        viewModelToTest.getMovieCredits(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Cast.with()], [Crew.with()]))
    }
    
    func testGetMovieCreditsError() {
        //Arrange
        mockInteractor.getMovieCreditsResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getMovieCredits(showLoader: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }
    
}

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

    private var useCaseProvider: MockUseCaseProvider!
    private var movieUseCase: MockMovieUseCase!
    
    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
    }
    
    override func tearDown() {
        useCaseProvider = nil
        movieUseCase = nil
        super.tearDown()
    }
    
    func testMovieCreditsTitle() {
        //Arrange
        let viewModel = MovieCreditsViewModel(movieId: 1,
                                              movieTitle: "Movie 1",
                                              useCaseProvider: useCaseProvider)
        //Act
        let title = viewModel.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie 1")
    }

}

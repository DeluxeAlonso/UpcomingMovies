//
//  MovieReviewsTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import NetworkInfrastructure

class MovieReviewsTests: XCTestCase {
    
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
    
    func testMovieReviewsTitle() {
        //Arrange
        let viewModel = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        let title = viewModel.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie 1")
    }
    
    func testGetReviewsEmpty() {
        //Arrange
        movieUseCase.reviews = Result.success([])
        let viewModel = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .empty)
    }
    
    func testGetReviewsPaging() {
        //Arrange
        movieUseCase.reviews = Result.success([Review.with(id: "1"), Review.with(id: "2")])
        let viewModel = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModel.viewState.value,
                       .paging([Review.with(id: "1"), Review.with(id: "2")], next: 2))
    }
    
    func testGetReviewsError() {
        //Arrange
        movieUseCase.reviews = Result.failure(APIError.badRequest)
        let viewModel = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
        //Act
        viewModel.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModel.viewState.value, .error(APIError.badRequest))
    }

}

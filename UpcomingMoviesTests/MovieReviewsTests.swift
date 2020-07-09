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
    
    private var movieUseCase: MockMovieUseCase!
    private var viewModelToTest: MovieReviewsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        movieUseCase = MockMovieUseCase(remoteDataSource: MockInjectionFactory.makeRemoteDataSource().movieDataSource())
        
        let useCaseProvider = (MockInjectionFactory.useCaseProvider() as! MockUseCaseProvider)
        useCaseProvider.mockMovieUseCase = self.movieUseCase
        
        viewModelToTest = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1", useCaseProvider: useCaseProvider)
    }
    
    override func tearDown() {
        movieUseCase = nil
        viewModelToTest = nil
        super.tearDown()
    }
    
    func testMovieReviewsTitle() {
        //Act
        let title = viewModelToTest.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie 1")
    }
    
    func testGetReviewsEmpty() {
        //Arrange
        movieUseCase.reviews = Result.success([])
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetReviewsPopulated() {
        //Arrange
        movieUseCase.reviews = Result.success([Review.with(id: "1"), Review.with(id: "2")])
        //Act
        viewModelToTest.getMovieReviews()
        movieUseCase.reviews = Result.success([])
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Review.with(id: "1"), Review.with(id: "2")]))
    }
    
    func testGetReviewsPaging() {
        //Arrange
        movieUseCase.reviews = Result.success([Review.with(id: "1"), Review.with(id: "2")])
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .paging([Review.with(id: "1"), Review.with(id: "2")], next: 2))
    }
    
    func testGetReviewsError() {
        //Arrange
        movieUseCase.reviews = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}

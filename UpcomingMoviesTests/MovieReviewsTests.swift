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
    
    private var interactor: MockMovieReviewsInteractor!
    private var viewModelToTest: MovieReviewsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        interactor = MockMovieReviewsInteractor()
        viewModelToTest = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1",
                                                interactor: interactor)
    }
    
    override func tearDown() {
        interactor = nil
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
        interactor.getMovieReviewsResult = Result.success([])
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetReviewsPopulated() {
        //Arrange
        interactor.getMovieReviewsResult = Result.success([Review.with(id: "1"), Review.with(id: "2")])
        //Act
        viewModelToTest.getMovieReviews()
        interactor.getMovieReviewsResult = Result.success([])
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Review.with(id: "1"), Review.with(id: "2")]))
    }
    
    func testGetReviewsPaging() {
        //Arrange
        interactor.getMovieReviewsResult = Result.success([Review.with(id: "1"), Review.with(id: "2")])
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .paging([Review.with(id: "1"), Review.with(id: "2")], next: 2))
    }
    
    func testGetReviewsError() {
        //Arrange
        interactor.getMovieReviewsResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getMovieReviews()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}

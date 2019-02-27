//
//  MovieReviewsTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieReviewsTests: XCTestCase {
    
    private var viewModelToTest: MovieReviewsViewModel!
    private var movieReviewCellViewModelToTest: MovieReviewCellViewModel!
    
    override func setUp() {
        super.setUp()
        viewModelToTest = MovieReviewsViewModel(movieId: 1, movieTitle: "Movie 1")
        movieReviewCellViewModelToTest = MovieReviewCellViewModel(Review.with())
    }
    
    override func tearDown() {
        viewModelToTest = nil
        movieReviewCellViewModelToTest = nil
        super.tearDown()
    }
    
    func testMovieReviewsTitle() {
        //Act
        let title = viewModelToTest.movieTitle
        //Assert
        XCTAssertEqual(title, "Movie 1")
    }

}

private final class MockMovieClient: MovieClient {
    
    var getReviewResult: Result<ReviewResult?, APIError>?
    
    override func getMovieReviews(page: Int, with movieId: Int, completion: @escaping (Result<ReviewResult?, APIError>) -> Void) {
        completion(getReviewResult!)
    }
    
}

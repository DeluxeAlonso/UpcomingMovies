//
//  MovieResultPaginationTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieResultPaginationTests: XCTestCase {
    
    var movieResultUnderTest: MovieResult!

    override func setUp() {
        super.setUp()
        movieResultUnderTest = MovieResult(results: [],
                                           currentPage: 1,
                                           totalPages: 2)
    }

    override func tearDown() {
        movieResultUnderTest = nil
        super.tearDown()
    }

    func testMovieResultHasMorePagesTrue() {
        //Act
        let hasMorePages = movieResultUnderTest.hasMorePages
        //Assert
        XCTAssertTrue(hasMorePages)
    }
    
    func testMovieResultHasMorePagesFalse() {
        //Arrange
        movieResultUnderTest.totalPages = 1
        //Act
        let hasMorePages = movieResultUnderTest.hasMorePages
        //Assert
        XCTAssertFalse(hasMorePages)
    }
    
    func testMovieResultNextPage() {
        //Act
        let nextPage = movieResultUnderTest.nextPage
        //Assert
        XCTAssertEqual(nextPage, 2)
    }

}

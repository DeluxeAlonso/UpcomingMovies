//
//  UpcomingMoviesTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class UpcomingMoviesTests: XCTestCase {
    
    var movieResultUnderTest: MovieResult!

    override func setUp() {
        super.setUp()
        movieResultUnderTest = MovieResult(results: nil,
                                           currentPage: 1,
                                           totalPages: 2)
    }

    override func tearDown() {
        movieResultUnderTest = nil
        super.tearDown()
    }
    
    // MARK: - Pagination Test
    
    func testMovieResultPagination() {
        // Act
        let hasMorePages = movieResultUnderTest.hasMorePages
        // Assert
        XCTAssertTrue(hasMorePages)
    }
    
    func testMovieResultNextPage() {
        // Act
        let nextPage = movieResultUnderTest.nextPage
        // Assert
        XCTAssertEqual(nextPage, 2)
    }

}

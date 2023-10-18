//
//  MovieResultPaginationTests.swift
//  NetworkInfrastructureTests
//
//  Created by Alonso on 11/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import NetworkInfrastructure

final class MovieResultPaginationTests: XCTestCase {

    func testMovieResultHasMorePagesTrue() {
        // Arrange
        let movieResultUnderTest = MovieResult(results: [], currentPage: 1, totalPages: 2)
        // Act
        let hasMorePages = movieResultUnderTest.hasMorePages
        // Assert
        XCTAssertTrue(hasMorePages)
    }

    func testMovieResultHasMorePagesFalse() {
        // Arrange
        let movieResultUnderTest = MovieResult(results: [], currentPage: 1, totalPages: 1)
        // Act
        let hasMorePages = movieResultUnderTest.hasMorePages
        // Assert
        XCTAssertFalse(hasMorePages)
    }

    func testMovieResultNextPage() {
        // Arrange
        let movieResultUnderTest = MovieResult(results: [], currentPage: 1, totalPages: 2)
        // Act
        let nextPage = movieResultUnderTest.nextPage
        // Assert
        XCTAssertEqual(nextPage, 2)
    }

}

//
//  MovieDetailOptionTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieDetailOptionTests: XCTestCase {

    func testMovieDetailOptionsTrailers() {
        // Arrange
        let option = MovieDetailOption.trailers
        // Act
        let title = option.title
        let iconName = option.iconName
        // Assert
        XCTAssertEqual(title, LocalizedStrings.trailersDetailOptions())
        XCTAssertEqual(iconName, "PlayVideo")
    }

    func testMovieDetailOptionsReviews() {
        // Arrange
        let option = MovieDetailOption.reviews
        // Act
        let title = option.title
        let iconName = option.iconName
        // Assert
        XCTAssertEqual(title, LocalizedStrings.reviewsDetailOptions())
        XCTAssertEqual(iconName, "Reviews")
    }

    func testMovieDetailOptionsCredits() {
        // Arrange
        let option = MovieDetailOption.credits
        // Act
        let title = option.title
        let iconName = option.iconName
        // Assert
        XCTAssertEqual(title, LocalizedStrings.creditsDetailOptions())
        XCTAssertEqual(iconName, "Cast")
    }

    func testMovieDetailOptionsSimilarMovies() {
        // Arrange
        let option = MovieDetailOption.similarMovies
        // Act
        let title = option.title
        let iconName = option.iconName
        // Assert
        XCTAssertEqual(title, LocalizedStrings.similarsDetailOptions())
        XCTAssertEqual(iconName, "SimilarMovies")
    }

}

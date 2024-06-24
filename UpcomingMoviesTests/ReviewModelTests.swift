//
//  ReviewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 23/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class ReviewModelTests: XCTestCase {

    func testInitWithReview() {
        // Arrange
        let review = Review.with(id: "12345", authorName: "Author", content: "Content")
        // Act
        let model = ReviewModel(review)
        // Assert
        XCTAssertEqual(review.id, "12345")
        XCTAssertEqual(review.content, "Content")
        XCTAssertEqual(review.authorName, "Author")
    }

}

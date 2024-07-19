//
//  MovieVisitModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 19/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieVisitModelTests: XCTestCase {

    func testInitWithMovieVisit() {
        // Arrange
        let movieVisit = MovieVisit.with(id: 12345, title: "Title", posterPath: "/path", createdAt: Date(timeIntervalSince1970: 0))
        // Act
        let model = MovieVisitModel(movieVisit)
        // Assert
        XCTAssertEqual(model.id, 12345)
        XCTAssertEqual(model.title, "Title")
        XCTAssertEqual(model.posterPath, "/path")
        XCTAssertEqual(model.createdAt?.timeIntervalSince1970, 0)
    }

}

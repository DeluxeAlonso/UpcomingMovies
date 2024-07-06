//
//  MovieCreditsModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 5/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieCreditsModelTests: XCTestCase {

    func testInitWithMovieCredits() {
        // Arrange
        let movieCredits = MovieCredits.with(cast: [Cast.with()], crew: [Crew.with()])
        // Act
        let model = MovieCreditsModel(movieCredits)
        // Assert
        XCTAssertEqual(model.cast.count, 1)
        XCTAssertEqual(model.crew.count, 1)
    }

}

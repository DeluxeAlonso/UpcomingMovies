//
//  MovieSearchModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 10/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieSearchModelTests: XCTestCase {

    func testInitWithMovieSearch() {
        // Arrange
        let movieSearch = MovieSearch(id: "12345", searchText: "Text", createdAt: Date(timeIntervalSince1970: 0))
        // Act
        let model = MovieSearchModel(movieSearch)
        // Assert
        XCTAssertEqual(model.id, "12345")
        XCTAssertEqual(model.searchText, "Text")
        XCTAssertEqual(model.createdAt.timeIntervalSince1970, 0)
    }

}

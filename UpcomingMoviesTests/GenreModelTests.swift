//
//  GenreModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 19/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class GenreModelTests: XCTestCase {

    func testInitWithGenre() {
        // Arrange
        let genre = Genre(id: 12345, name: "Action")
        // Act
        let model = GenreModel(genre)
        // Assert
        XCTAssertEqual(model.id, 12345)
        XCTAssertEqual(model.name, "Action")
    }

}

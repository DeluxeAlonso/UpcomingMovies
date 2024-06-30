//
//  CastModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 25/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class CastModelTests: XCTestCase {

    func testInitWithCast() {
        // Arrange
        let cast = Cast.with(id: 12345, character: "Character", name: "Name", photoPath: "/path")
        let configurationHandler = MockConfigurationHandlerProtocol(regularImageBaseURLString: "https://image.tmdb.org/t/p/cast")
        // Act
        let model = CastModel(cast, configurationHandler: configurationHandler)
        // Assert
        XCTAssertEqual(model.id, 12345)
        XCTAssertEqual(model.character, "Character")
        XCTAssertEqual(model.name, "Name")
        XCTAssertEqual(model.profileURL?.absoluteString, "https://image.tmdb.org/t/p/cast/path")
    }

}

//
//  CrewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 24/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class CrewModelTests: XCTestCase {

    func testInitWithCrew() {
        // Arrange
        let crew = Crew.with(id: 12345, job: "Job", name: "Name", photoPath: "/path")
        // Act
        let model = CrewModel(crew)
        // Assert
        XCTAssertEqual(model.id, 12345)
        XCTAssertEqual(model.job, "Job")
        XCTAssertEqual(model.name, "Name")
        XCTAssertEqual(model.profileURL?.absoluteString, "https://image.tmdb.org/t/p/w342/path")
    }

}


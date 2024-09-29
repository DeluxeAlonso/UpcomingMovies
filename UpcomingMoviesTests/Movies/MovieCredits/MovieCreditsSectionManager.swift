//
//  MovieCreditsSectionManager.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 3/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieCreditsSectionManagerTests: XCTestCase {

    private var factory: MovieCreditsSectionManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        factory = MovieCreditsSectionManager()
    }

    override func tearDownWithError() throws {
        factory = nil
        try super.tearDownWithError()
    }

    func testCastSection() {
        // Act
        let sections = factory.sections
        let castSection = sections[0]
        // Assert
        XCTAssertEqual(castSection.type, .cast)
        XCTAssertTrue(castSection.opened)
    }

    func testCrewSection() {
        // Act
        let sections = factory.sections
        let crewSection = sections[1]
        // Assert
        XCTAssertEqual(crewSection.type, .crew)
        XCTAssertFalse(crewSection.opened)
    }

}

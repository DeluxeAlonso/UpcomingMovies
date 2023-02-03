//
//  MovieCreditsFactoryTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 3/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieCreditsFactoryTests: XCTestCase {

    private var factory: MovieCreditsFactory!

    override func setUpWithError() throws {
        try super.setUpWithError()
        factory = MovieCreditsFactory()
    }

    override func tearDownWithError() throws {
        factory = nil
        try super.tearDownWithError()
    }

    func testSections() {
        // Arrange
        let expectedSections: [MovieCreditsCollapsibleSection] = [
            MovieCreditsCollapsibleSection(type: .cast, opened: true),
            MovieCreditsCollapsibleSection(type: .crew, opened: false)
        ]
        // Act
        let sections = factory.sections
        // Assert
        XCTAssertEqual(sections, expectedSections)
    }
}

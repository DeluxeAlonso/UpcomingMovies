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

    private var manager: MovieCreditsSectionManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        manager = MovieCreditsSectionManager()
    }

    override func tearDownWithError() throws {
        manager = nil
        try super.tearDownWithError()
    }

    func testCastSection() {
        // Act
        let sections = manager.sections
        let castSection = sections[0]
        // Assert
        XCTAssertEqual(castSection.type, .cast)
        XCTAssertTrue(castSection.opened)
    }

    func testCrewSection() {
        // Act
        let sections = manager.sections
        let crewSection = sections[1]
        // Assert
        XCTAssertEqual(crewSection.type, .crew)
        XCTAssertFalse(crewSection.opened)
    }

    func testCastSectionEnabledFalse() {
        // Act
        manager.updateSection(type: .cast, enabled: false)
        // Assert
        XCTAssertEqual(manager.sections.count, 1)
        XCTAssertFalse(manager.sections.contains(where: { $0.type == .cast }))
    }

    func testCrewSectionEnabledFalse() {
        // Act
        manager.updateSection(type: .crew, enabled: false)
        // Assert
        XCTAssertEqual(manager.sections.count, 1)
        XCTAssertFalse(manager.sections.contains(where: { $0.type == .crew }))
    }

    func testCastSectionToggle() {
        // Act
        manager.toggleSection(at: 0)
        let sections = manager.sections
        let castSection = sections[0]
        // Assert
        XCTAssertFalse(castSection.opened)
    }

    func testCrewSectionToggle() {
        // Act
        manager.toggleSection(at: 1)
        let sections = manager.sections
        let castSection = sections[1]
        // Assert
        XCTAssertTrue(castSection.opened)
    }

}

//
//  ProfileFactoryTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 1/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class ProfileFactoryTests: XCTestCase {

    private var factory: ProfileFactory!

    override func setUpWithError() throws {
        try super.setUpWithError()
        factory = ProfileFactory()
    }

    override func tearDownWithError() throws {
        factory = nil
        try super.tearDownWithError()
    }

    func testSections() {
        // Arrange
        let expectedSections: [ProfileSection] = [
            .accountInfo,
            .collections,
            .recommended,
            .customLists,
            .signOut
        ]
        // Act
        let sections = factory.sections
        // Assert
        XCTAssertEqual(sections, expectedSections)
    }

    func testProfileOptionForAccountInfoSection() {
        // Arrange
        let expectedProfileOptions: [ProfileOptionProtocol] = []
        // Act
        let profileOptions = factory.profileOptions(for: .accountInfo)
        // Assert
        XCTAssertEqual(profileOptions, expectedProfileOptions)
    }
}

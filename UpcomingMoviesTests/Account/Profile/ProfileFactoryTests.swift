//
//  ProfileFactoryTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 1/02/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class ProfileFactoryTests: XCTestCase {

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
        let expectedProfileOptionsIdentifiers = expectedProfileOptions.map { $0.identifier }
        // Act
        let profileOptions = factory.profileOptions(for: .accountInfo)
        let profileOptionsIdentifier = profileOptions.map { $0.identifier }
        // Assert
        XCTAssertEqual(profileOptionsIdentifier, expectedProfileOptionsIdentifiers)
    }

    func testProfileOptionForSignOutSection() {
        // Arrange
        let expectedProfileOptions: [ProfileOptionProtocol] = []
        let expectedProfileOptionsIdentifiers = expectedProfileOptions.map { $0.identifier }
        // Act
        let profileOptions = factory.profileOptions(for: .signOut)
        let profileOptionsIdentifier = profileOptions.map { $0.identifier }
        // Assert
        XCTAssertEqual(profileOptionsIdentifier, expectedProfileOptionsIdentifiers)
    }

    func testProfileOptionForCollectionsSection() {
        // Arrange
        let expectedProfileOptions: [ProfileOptionProtocol] = [ProfileOption.favorites, ProfileOption.watchlist]
        let expectedProfileOptionsIdentifiers = expectedProfileOptions.map { $0.identifier }
        // Act
        let profileOptions = factory.profileOptions(for: .collections)
        let profileOptionsIdentifier = profileOptions.map { $0.identifier }
        // Assert
        XCTAssertEqual(profileOptionsIdentifier, expectedProfileOptionsIdentifiers)
    }

    func testProfileOptionForRecommendedSection() {
        // Arrange
        let expectedProfileOptions: [ProfileOptionProtocol] = [ProfileOption.recommended]
        let expectedProfileOptionsIdentifiers = expectedProfileOptions.map { $0.identifier }
        // Act
        let profileOptions = factory.profileOptions(for: .recommended)
        let profileOptionsIdentifier = profileOptions.map { $0.identifier }
        // Assert
        XCTAssertEqual(profileOptionsIdentifier, expectedProfileOptionsIdentifiers)
    }

    func testProfileOptionForCustomListsSection() {
        // Arrange
        let expectedProfileOptions: [ProfileOptionProtocol] = [ProfileOption.customLists]
        let expectedProfileOptionsIdentifiers = expectedProfileOptions.map { $0.identifier }
        // Act
        let profileOptions = factory.profileOptions(for: .customLists)
        let profileOptionsIdentifier = profileOptions.map { $0.identifier }
        // Assert
        XCTAssertEqual(profileOptionsIdentifier, expectedProfileOptionsIdentifiers)
    }
}

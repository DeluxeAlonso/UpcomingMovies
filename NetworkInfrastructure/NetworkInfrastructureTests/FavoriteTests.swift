//
//  FavoriteTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class FavoriteTests: XCTestCase {

    func testMissingStatusCodeFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.markAsFavorite.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_code")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(MarkAsFavoriteResult.self, from: jsonDataToTest))
    }

    func testMissingStatusMessageFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.markAsFavorite.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_message")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(MarkAsFavoriteResult.self, from: jsonDataToTest))
    }

    func testMissingStatusCodeAndMessageFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.markAsFavorite.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_code", "status_message")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(MarkAsFavoriteResult.self, from: jsonDataToTest))
    }

}

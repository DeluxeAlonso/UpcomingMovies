//
//  MarkAsFavoriteTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class MarkAsFavoriteTests: XCTestCase {

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

    func testStatusCodeFromResponse() throws {
        // Arrange
        let statusCodeToTest = 200
        let dataResponse = MockResponse.markAsFavorite.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("status_code", statusCodeToTest))
        let decodedMarkAsFavoriteResult = try JSONDecoder().decode(MarkAsFavoriteResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedMarkAsFavoriteResult.statusCode, statusCodeToTest)
    }

    func testStatusMessageFromResponse() throws {
        // Arrange
        let statusMessageToTest = "statusMessage"
        let dataResponse = MockResponse.markAsFavorite.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("status_message", statusMessageToTest))
        let decodedMarkAsFavoriteResult = try JSONDecoder().decode(MarkAsFavoriteResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedMarkAsFavoriteResult.statusMessage, statusMessageToTest)
    }

}

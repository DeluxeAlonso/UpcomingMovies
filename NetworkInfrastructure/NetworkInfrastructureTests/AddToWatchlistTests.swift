//
//  AddToWatchlistTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 15/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class AddToWatchlistTests: XCTestCase {

    func testMissingStatusCodeFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.addToWatchlist.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_code")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(AddToWatchlistResult.self, from: jsonDataToTest))
    }

    func testMissingStatusMessageFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.addToWatchlist.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_message")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(AddToWatchlistResult.self, from: jsonDataToTest))
    }

    func testStatusCodeFromResponse() throws {
        // Arrange
        let statusCodeToTest = 200
        let dataResponse = MockResponse.addToWatchlist.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("status_code", statusCodeToTest))
        let decodedAddToWatchlistResult = try JSONDecoder().decode(AddToWatchlistResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedAddToWatchlistResult.statusCode, statusCodeToTest)
    }

    func testStatusMessageFromResponse() throws {
        // Arrange
        let statusMessageToTest = "statusMessage"
        let dataResponse = MockResponse.markAsFavorite.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("status_message", statusMessageToTest))
        let decodedAddToWatchlistResult = try JSONDecoder().decode(AddToWatchlistResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedAddToWatchlistResult.statusMessage, statusMessageToTest)
    }

}

//
//  RateMovieTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 26/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class RateMovieTests: XCTestCase {

    func testMissingStatusCodeFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.rateMovie.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_code")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RateMovieResult.self, from: jsonDataToTest))
    }

    func testMissingStatusMessageFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.rateMovie.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "status_message")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RateMovieResult.self, from: jsonDataToTest))
    }

    func testStatusCodeFromResponse() throws {
        // Arrange
        let statusCodeToTest = 200
        let dataResponse = MockResponse.rateMovie.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("status_code", statusCodeToTest))
        let decodedRateMovieResult = try JSONDecoder().decode(RateMovieResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedRateMovieResult.statusCode, statusCodeToTest)
    }

    func testStatusMessageFromResponse() throws {
        // Arrange
        let statusMessageToTest = "statusMessage"
        let dataResponse = MockResponse.rateMovie.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("status_message", statusMessageToTest))
        let decodedRateMovieResult = try JSONDecoder().decode(RateMovieResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedRateMovieResult.statusMessage, statusMessageToTest)
    }

}

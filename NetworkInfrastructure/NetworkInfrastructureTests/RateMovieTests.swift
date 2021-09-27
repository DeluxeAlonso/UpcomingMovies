//
//  RateMovieTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 26/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class RateMovieTests: XCTestCase {

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
    
}

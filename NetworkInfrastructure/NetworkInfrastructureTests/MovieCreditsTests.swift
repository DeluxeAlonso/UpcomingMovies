//
//  MovieCreditsTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 19/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class MovieCreditsTests: XCTestCase {

    func testMissingIdFromCastResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonDataToTest))
    }

    func testMissingCharacterFromCastResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "character")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonDataToTest))
    }

    func testMissingNameFromCastResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "name")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonDataToTest))
    }

}

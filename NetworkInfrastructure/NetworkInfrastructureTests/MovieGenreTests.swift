//
//  MovieGenreTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 25/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class MovieGenreTests: XCTestCase {

    func testMissingIdFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.genre.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Genre.self, from: jsonDataToTest))
    }

    func testMissingNameFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.genre.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "name")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Genre.self, from: jsonDataToTest))
    }

}

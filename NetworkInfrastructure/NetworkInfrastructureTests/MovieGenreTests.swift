//
//  MovieGenreTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 25/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class MovieGenreTests: XCTestCase {

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

    func testIdFromResponse() throws {
        // Arrange
        let idToTest = 123456
        let dataResponse = MockResponse.genre.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("id", idToTest))
        let decodedGenre = try JSONDecoder().decode(Genre.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedGenre.id, idToTest)
    }

    func testNameFromResponse() throws {
        // Arrange
        let nameToTest = "name"
        let dataResponse = MockResponse.genre.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("name", nameToTest))
        let decodedGenre = try JSONDecoder().decode(Genre.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedGenre.name, nameToTest)
    }

}

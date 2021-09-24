//
//  MovieReviewTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 24/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class MovieReviewTests: XCTestCase {

    func testMissingIdFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.review.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Review.self, from: jsonDataToTest))
    }

    func testMissingAuthorFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.review.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "author")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Review.self, from: jsonDataToTest))
    }

    func testMissingContentFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.review.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "content")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Review.self, from: jsonDataToTest))
    }

}

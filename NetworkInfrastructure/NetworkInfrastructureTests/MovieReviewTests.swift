//
//  MovieReviewTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 24/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class MovieReviewTests: XCTestCase {

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

    func testIdFromResponse() throws {
        // Arrange
        let idToTest = "reviewId"
        let dataResponse = MockResponse.review.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("id", idToTest))
        let decodedReview = try JSONDecoder().decode(Review.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedReview.id, idToTest)
    }

    func testAuthorFromResponse() throws {
        // Arrange
        let authorToTest = "author"
        let dataResponse = MockResponse.review.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("author", authorToTest))
        let decodedReview = try JSONDecoder().decode(Review.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedReview.authorName, authorToTest)
    }

    func testContentFromResponse() throws {
        // Arrange
        let contentToTest = "content"
        let dataResponse = MockResponse.review.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("content", contentToTest))
        let decodedReview = try JSONDecoder().decode(Review.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedReview.content, contentToTest)
    }

}

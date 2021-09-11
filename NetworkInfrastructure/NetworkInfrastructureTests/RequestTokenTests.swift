//
//  RequestTokenTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 10/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class RequestTokenTests: XCTestCase {

    func testMissingSuccessFromDecodedRequestToken() throws {
        // Arrange
        let dataResponse = MockResponse.requestToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "success")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest))
    }

    func testMissingTokenFromDecodedRequestToken() throws {
        // Arrange
        let dataResponse = MockResponse.requestToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "request_token")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest))
    }

    func testMissingSuccessAndTokenFromDecodedRequestToken() throws {
        // Arrange
        let dataResponse = MockResponse.requestToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "success", "request_token")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest))
    }

    func testSuccessFromDecodedRequestToken() throws {
        // Arrange
        let successToTest = true
        let dataResponse = MockResponse.requestToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("success", successToTest))
        let decodedRequestToken = try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedRequestToken.success, successToTest)
    }

    func testTokenFromDecodedRequestToken() throws {
        // Arrange
        let tokenToTest = "test"
        let dataResponse = MockResponse.requestToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("request_token", tokenToTest))
        let decodedRequestToken = try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedRequestToken.token, tokenToTest)
    }

}

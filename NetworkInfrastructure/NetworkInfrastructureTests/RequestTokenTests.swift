//
//  RequestTokenTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 10/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class RequestTokenTests: XCTestCase {

    func testMissingSuccessFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.requestTokenResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "success")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest))
    }

    func testMissingTokenFromDResponse() throws {
        // Arrange
        let dataResponse = MockResponse.requestTokenResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "request_token")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest))
    }

    func testSuccessFromResponse() throws {
        // Arrange
        let successToTest = true
        let dataResponse = MockResponse.requestTokenResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("success", successToTest))
        let decodedRequestToken = try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedRequestToken.success, successToTest)
    }

    func testTokenFromResponse() throws {
        // Arrange
        let tokenToTest = "test"
        let dataResponse = MockResponse.requestTokenResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("request_token", tokenToTest))
        let decodedRequestToken = try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedRequestToken.token, tokenToTest)
    }

}

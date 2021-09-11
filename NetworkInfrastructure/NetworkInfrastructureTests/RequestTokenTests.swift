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

    func testMissingTokenFromDecodedAccessToken() throws {
        // Arrange
        let dataResponse = MockResponse.requestToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "request_token")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(RequestTokenResult.self, from: jsonDataToTest))
    }

}

//
//  AccessTokenTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 9/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class AccessTokenTests: XCTestCase {

    func testMissingAccounIdFromDecodedAccessToken() throws {
        // Arrange
        let dataResponse = MockResponse.accessToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "account_id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest))
    }

    func testMissingTokenFromDecodedAccessToken() throws {
        // Arrange
        let dataResponse = MockResponse.accessToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "access_token")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest))
    }

    func testMissingAccounIdAndTokenFromDecodedAccessToken() throws {
        // Arrange
        let dataResponse = MockResponse.accessToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "account_id", "access_token")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest))
    }

    func testAccounIdFromDecodedAccessToken() throws {
        // Arrange
        let accountIdToTest = "accountId"
        let dataResponse = MockResponse.accessToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("account_id", accountIdToTest))
        let decodedAccessToken = try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedAccessToken.accountId, accountIdToTest)
    }

    func testTokenFromDecodedAccessToken() throws {
        // Arrange
        let tokenToTest = "token"
        let dataResponse = MockResponse.accessToken.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("access_token", tokenToTest))
        let decodedAccessToken = try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedAccessToken.token, tokenToTest)
    }

}

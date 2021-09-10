//
//  AccessTokenTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 9/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class AccessTokenTests: XCTestCase {

    let accessTokenDataResponse = Data("""
        {
          "account_id": "4bc8892a017a3c0z92001001",
          "access_token": "eyJhbGciOiJIUzI1NiIsInR"
        }
        """.utf8)

    func testAccounIdFromDecodedAccessToken() throws {
        // Arrange
        let accountIdToTest = "accountId"
        let jsonDataToTest = try accessTokenDataResponse.json(updatingKeyPaths: ("account_id", accountIdToTest))
        // Act
        let decodedAccessToken = try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedAccessToken.accountId, accountIdToTest)
    }

    func testTokenFromDecodedAccessToken() throws {
        // Arrange
        let tokenToTest = "token"
        let jsonDataToTest = try accessTokenDataResponse.json(updatingKeyPaths: ("access_token", tokenToTest))
        // Act
        let decodedAccessToken = try JSONDecoder().decode(AccessToken.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedAccessToken.token, tokenToTest)
    }

}

extension Data {

    func json(updatingKeyPaths keyPaths: (String, Any)...) throws -> Data {
        let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject

        for (keyPath, value) in keyPaths {
            decoded.setValue(value, forKeyPath: keyPath)
        }

        return try JSONSerialization.data(withJSONObject: decoded)
    }

}

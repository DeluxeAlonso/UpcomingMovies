//
//  SessionTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 15/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class SessionTests: XCTestCase {

    func testMissingSuccessFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.session.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "success")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest))
    }

    func testMissingSessionIdFromDResponse() throws {
        // Arrange
        let dataResponse = MockResponse.session.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "session_id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest))
    }

    func testMissingSuccessAndSessionIdFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.session.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "success", "session_id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest))
    }

}

//
//  SessionTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 15/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class SessionTests: XCTestCase {

    func testMissingSuccessFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.sessionResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "success")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest))
    }

    func testMissingSessionIdFromDResponse() throws {
        // Arrange
        let dataResponse = MockResponse.sessionResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "session_id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest))
    }

    func testSessionIdFromResponse() throws {
        // Arrange
        let sessionIdToTest = "sessionId"
        let dataResponse = MockResponse.sessionResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("session_id", sessionIdToTest))
        let decodedSessionResult = try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedSessionResult.sessionId, sessionIdToTest)
    }

    func testSuccessFromResponse() throws {
        // Arrange
        let successToTest = true
        let dataResponse = MockResponse.sessionResult.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("success", successToTest))
        let decodedSessionResult = try JSONDecoder().decode(SessionResult.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedSessionResult.success, successToTest)
    }

}

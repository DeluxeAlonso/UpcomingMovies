//
//  VideosTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 17/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class VideosTests: XCTestCase {

    func testIdFromResponse() throws {
        // Arrange
        let idToTest = "videoId"
        let dataResponse = MockResponse.video.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("id", idToTest))
        let decodedVideo = try JSONDecoder().decode(Video.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedVideo.id, idToTest)
    }

    func testKeyFromResponse() throws {
        // Arrange
        let keyToTest = "videoKey"
        let dataResponse = MockResponse.video.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("key", keyToTest))
        let decodedVideo = try JSONDecoder().decode(Video.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedVideo.id, keyToTest)
    }

    func testNameFromResponse() throws {
        // Arrange
        let nameToTest = "videoName"
        let dataResponse = MockResponse.video.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("name", nameToTest))
        let decodedVideo = try JSONDecoder().decode(Video.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedVideo.name, nameToTest)
    }

    func testSiteFromResponse() throws {
        // Arrange
        let siteToTest = "videoSite"
        let dataResponse = MockResponse.video.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("site", siteToTest))
        let decodedVideo = try JSONDecoder().decode(Video.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedVideo.site, siteToTest)
    }

}

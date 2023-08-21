//
//  MovieImagesConfigurationTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 29/09/21.
//

import XCTest
@testable import NetworkInfrastructure

final class MovieImagesConfigurationTests: XCTestCase {

    func testMissingBaseURLStringFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.imageConfiguration.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "secure_base_url")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ImagesConfiguration.self, from: jsonDataToTest))
    }

    func testMissingBackdropSizesFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.imageConfiguration.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "backdrop_sizes")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ImagesConfiguration.self, from: jsonDataToTest))
    }

    func testMissingPosterSizesFromResponse() throws {
        // Arrange
        let dataResponse = MockResponse.imageConfiguration.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "poster_sizes")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ImagesConfiguration.self, from: jsonDataToTest))
    }

    func testBaseURLStringFromResponse() throws {
        // Arrange
        let urlToTest = "urlTest"
        let dataResponse = MockResponse.imageConfiguration.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("secure_base_url", urlToTest))
        let decodedImageConfiguration = try JSONDecoder().decode(ImagesConfiguration.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedImageConfiguration.baseURLString, urlToTest)
    }

}

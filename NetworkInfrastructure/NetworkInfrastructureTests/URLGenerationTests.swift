//
//  URLGenerationTests.swift
//  NetworkInfrastructureTests
//
//  Created by Alonso on 5/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import NetworkInfrastructure

final class URLGenerationTests: XCTestCase {

    func testURLRequestSetJsonContentType() {
        // Arrange
        var urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org")!)
        // Act
        urlRequest.setJSONContentType()
        let allHeaderFields = urlRequest.allHTTPHeaderFields
        // Assert
        XCTAssertNotNil(allHeaderFields!["Content-Type"])
    }

    func testURLRequestSetJsonContentTypeNil() {
        // Arrange
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org")!)
        // Act
        let allHeaderFields = urlRequest.allHTTPHeaderFields
        // Assert
        XCTAssertNil(allHeaderFields)
    }

    func testPercentEscapedEmptyParamters() {
        // Arrange
        let parametersDictionary: [String: Any] = [:]
        // Act
        let percentEscapedParameters = parametersDictionary.percentEscaped()
        // Assert
        XCTAssertTrue(percentEscapedParameters.isEmpty)
    }

    func testPercentEscapedSingleParameters() {
        // Arrange
        let parametersDictionary: [String: Any] = ["Param1": "A"]
        // Act
        let percentEscapedParameters = parametersDictionary.percentEscaped()
        // Assert
        XCTAssertEqual(percentEscapedParameters, "Param1=A")
    }

    func testPercentEscapedMultipleParameters() {
        // Arrange
        let parametersDictionary: [String: Any] = ["Param1": "A", "Param2": "B"]
        // Act
        let percentEscapedParameters = parametersDictionary.percentEscaped()
        let possibleEscapedParameters = ["Param1=A&Param2=B", "Param2=B&Param1=A"]
        // Assert
        XCTAssertTrue(possibleEscapedParameters.contains(percentEscapedParameters))
    }

}

//
//  ToastDefaultConfigurationTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 16/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class ToastDefaultConfigurationTests: XCTestCase {

    func testSuccessConfiguration() throws {
        // Act
        let configuration = ToastDefaultConfiguration.success.configuration
        // Assert
        XCTAssertNotNil(configuration as? ToastSuccessConfiguration)
    }

    func testFailureConfiguration() throws {
        // Act
        let configuration = ToastDefaultConfiguration.failure.configuration
        // Assert
        XCTAssertNotNil(configuration as? ToastFailureConfiguration)
    }

}

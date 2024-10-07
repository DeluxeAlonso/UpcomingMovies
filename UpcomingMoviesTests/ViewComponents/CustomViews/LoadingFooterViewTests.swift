//
//  LoadingFooterViewTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 5/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class LoadingFooterViewTests: XCTestCase {

    func testInit() {
        // Arrange
        let view = LoadingFooterView()
        let recommendedFrame = LoadingFooterView.recommendedFrame
        // Act
        let frame = view.frame
        // Assert
        XCTAssertEqual(frame, recommendedFrame)
    }

    func testInitWithFrame() {
        // Arrange
        // Act
        // Assert
    }
}

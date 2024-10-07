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
        let frameToTest = LoadingFooterView.recommendedFrame
        let view = LoadingFooterView()
        // Act
        let frame = view.frame
        // Assert
        XCTAssertEqual(frame, frameToTest)
    }

    func testInitWithFrame() {
        // Arrange
        let frameToTest = CGRect(x: 0, y: 0, width: 200, height: 200)
        let view = LoadingFooterView(frame: frameToTest)
        // Act
        let frame = view.frame
        // Assert
        XCTAssertEqual(frame, frameToTest)
    }
}

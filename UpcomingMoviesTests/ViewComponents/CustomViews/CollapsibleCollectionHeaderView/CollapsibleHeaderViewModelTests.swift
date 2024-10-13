//
//  CollapsibleHeaderViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 10/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class CollapsibleHeaderViewModelTests: XCTestCase {

    func testInitWithDefaultShouldAnimate() {
        // Arrange
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title")
        // Assert
        XCTAssertEqual(viewModel.opened, true)
        XCTAssertEqual(viewModel.section, 0)
        XCTAssertEqual(viewModel.title, "Title")
        XCTAssertEqual(viewModel.shouldAnimate, false)
    }

    func testInitWithShouldAnimateTrue() {
        // Arrange
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title", shouldAnimate: true)
        // Act
        let shouldAnimate = viewModel.shouldAnimate
        // Assert
        XCTAssertEqual(shouldAnimate, true)
    }

    func testInitWithShouldAnimateFalse() {
        // Arrange
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title", shouldAnimate: false)
        // Act
        let shouldAnimate = viewModel.shouldAnimate
        // Assert
        XCTAssertEqual(shouldAnimate, false)
    }

    func testArrowRotationValueOpenedState() {
        // Arrange
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title", shouldAnimate: false)
        // Act
        let arrowRotationValue = viewModel.arrowRotationValue()
        // Assert
        XCTAssertEqual(arrowRotationValue, CGFloat.pi / 2)
    }

    func testArrowRotationValueNonOpenedState() {
        // Arrange
        let viewModel = CollapsibleHeaderViewModel(opened: false, section: 0, title: "Title", shouldAnimate: false)
        // Act
        let arrowRotationValue = viewModel.arrowRotationValue()
        // Assert
        XCTAssertEqual(arrowRotationValue, 0.0)
    }

}

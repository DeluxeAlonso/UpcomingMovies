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
        // Act
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title")
        // Assert
        XCTAssertEqual(viewModel.opened, true)
        XCTAssertEqual(viewModel.section, 0)
        XCTAssertEqual(viewModel.title, "Title")
        XCTAssertEqual(viewModel.shouldAnimate, false)
    }

    func testInitWithShouldAnimateTrue() {
        // Act
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title", shouldAnimate: true)
        // Assert
        XCTAssertEqual(viewModel.shouldAnimate, true)
    }

    func testInitWithShouldAnimateFalse() {
        // Act
        let viewModel = CollapsibleHeaderViewModel(opened: true, section: 0, title: "Title", shouldAnimate: false)
        // Assert
        XCTAssertEqual(viewModel.shouldAnimate, false)
    }

}

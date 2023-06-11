//
//  MovieReviewDetailCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieReviewDetailCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        try super.tearDownWithError()
    }

    func testStart() {
        // Arrange
        let coordinator = MovieReviewDetailCoordinator(navigationController: navigationController,
                                                       review: .with())
        let presentingViewController = MockViewController()
        coordinator.presentingViewController = presentingViewController
        // Act
        coordinator.start()
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
        XCTAssertEqual(presentingViewController.presentCount, 1)
    }

    func testDismiss() {
        // Arrange
        let coordinator = MovieReviewDetailCoordinator(navigationController: navigationController,
                                                       review: .with())
        let topViewController = MockViewController()
        navigationController.mockTopViewController = topViewController
        // Act
        coordinator.dismiss()
        // Assert
        XCTAssertEqual(topViewController.dismissCount, 1)
    }

}

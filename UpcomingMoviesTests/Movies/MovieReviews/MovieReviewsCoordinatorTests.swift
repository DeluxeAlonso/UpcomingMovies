//
//  MovieReviewsCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieReviewsCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        try super.tearDownWithError()
    }

    func testBuild() {
        // Arrange
        let coordinator = MovieReviewsCoordinator(navigationController: navigationController, movieId: 1, movieTitle: "Title")
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.coordinator)
    }

    func testShowReviewDetail() {
        // Arrange
        let coordinator = MovieReviewsCoordinator(navigationController: navigationController, movieId: 1, movieTitle: "Title")
        navigationController.topViewControllerResult = MockViewController()
        // Act
        coordinator.showReviewDetail(for: MockReviewProtocol())
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieReviewDetailCoordinatorProtocol)
    }

    func testShowReviewDetailWithoutTopViewController() {
        // Arrange
        let coordinator = MovieReviewsCoordinator(navigationController: navigationController, movieId: 1, movieTitle: "Title")
        navigationController.topViewControllerResult = nil
        // Act
        coordinator.showReviewDetail(for: MockReviewProtocol())
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 0)
    }

}

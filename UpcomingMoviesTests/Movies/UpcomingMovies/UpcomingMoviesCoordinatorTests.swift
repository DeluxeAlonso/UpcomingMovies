//
//  UpcomingMoviesCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class UpcomingMoviesCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        try super.tearDownWithError()
    }

    func testRootIdentifier() {
        // Arrange
        let coordinator = createSUT()
        // Act
        let rootIdentifier = coordinator.rootIdentifier
        // Assert
        XCTAssertEqual(rootIdentifier, RootCoordinatorIdentifier.upcomingMovies)
    }

    func testStart() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.start()
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
    }

    func testShowMovieDetail() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.showMovieDetail(for: .with(),
                                    with: .init(selectedFrame: .zero, imageToTransition: .actions, transitionOffset: .leastNonzeroMagnitude))
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieDetailCoordinatorProtocol)
    }

    private func createSUT() -> UpcomingMoviesCoordinator {
        UpcomingMoviesCoordinator(navigationController: navigationController)
    }

}

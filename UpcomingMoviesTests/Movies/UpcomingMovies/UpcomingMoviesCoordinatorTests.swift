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
    var navigationDelegate: MockUpcomingMoviesNavigationDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        navigationDelegate = MockUpcomingMoviesNavigationDelegate()
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

    func testBuild() {
        // Arrange
        let coordinator = createSUT()
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.layoutProvider)
        XCTAssertNotNil(viewController.coordinator)
    }

    func testShowMovieDetail() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.showMovieDetail(for: MockMovieProtocol(),
                                    with: .init(selectedFrame: .zero, imageToTransition: .actions, transitionOffset: .leastNonzeroMagnitude))
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieDetailCoordinatorProtocol)
        XCTAssertEqual(navigationDelegate.configureCallCount, 1)
        XCTAssertEqual(navigationDelegate.updateOffsetCallCount, 1)
    }

    func testSetupNavigationControllerDelegate() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.setupNavigationControllerDelegate()
        // Assert
        XCTAssertEqual(navigationController.delegate?.description, navigationDelegate.description)
    }

    private func createSUT() -> UpcomingMoviesCoordinator {
        UpcomingMoviesCoordinator(navigationController: navigationController, navigationDelegate: navigationDelegate)
    }

}

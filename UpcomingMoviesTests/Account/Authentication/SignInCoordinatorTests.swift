//
//  SignInCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class SignInCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!
    var delegate: MockSignInViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        delegate = MockSignInViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testBuild() {
        // Arrange
        let coordinator = createSUT()
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.delegate)
    }

    func testShowAuthPermission() {
        // Arrange
        navigationController.topViewControllerResult = MockViewController()
        let coordinator = createSUT()
        let delegate = MockAuthPermissionViewControllerDelegate()
        let testURL = URL(string: "www.google.com")!
        // Act
        coordinator.showAuthPermission(for: testURL, and: delegate)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is AuthPermissionCoordinatorProtocol)
    }

    func testShowAuthPermissionWithoutTopViewController() {
        // Arrange
        navigationController.topViewControllerResult = nil
        let coordinator = createSUT()
        let delegate = MockAuthPermissionViewControllerDelegate()
        let testURL = URL(string: "www.google.com")!
        // Act
        coordinator.showAuthPermission(for: testURL, and: delegate)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 0)
    }

    private func createSUT() -> SignInCoordinator {
        SignInCoordinator(navigationController: navigationController, delegate: delegate)
    }

}

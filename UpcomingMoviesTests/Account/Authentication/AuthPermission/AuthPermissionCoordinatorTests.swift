//
//  AuthPermissionCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 5/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class AuthPermissionCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!
    var delegate: MockAuthPermissionViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        delegate = MockAuthPermissionViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testBuild() {
        // Arrange
        let coordinator = createSUT(authPermissionURL: URL(string: "www.google.com")!)
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.coordinator)
        XCTAssertNotNil(viewController.delegate)
    }

    func testDidDismiss() {
        // Arrange
        let coordinator = createSUT(authPermissionURL: URL(string: "www.google.com")!)
        let parentCoordinator = MockCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        // Act
        coordinator.didDismiss()
        // Assert
        XCTAssertEqual(parentCoordinator.childDidFinishCallCount, 1)
    }

    private func createSUT(authPermissionURL: URL) -> AuthPermissionCoordinator {
        AuthPermissionCoordinator(navigationController: navigationController,
                                  authPermissionURL: authPermissionURL,
                                  authPermissionDelegate: delegate)
    }

}

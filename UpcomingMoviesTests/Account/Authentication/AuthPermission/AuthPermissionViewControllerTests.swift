//
//  AuthPermissionViewControllerTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 17/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class AuthPermissionViewControllerTests: XCTestCase {

    private var viewModel: MockAuthPermissionViewModel!
    private var coordinator: MockAuthPermissionCoordinator!
    private var delegate: MockAuthPermissionViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockAuthPermissionViewModel()
        coordinator = MockAuthPermissionCoordinator()
        delegate = MockAuthPermissionViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        coordinator = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testCloseBarButtonAction() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        coordinator.dismissResult = ()
        // Act
        viewController.perform(#selector(AuthPermissionViewController.closeBarButtonAction), with: nil)
        // Assert
        XCTAssertEqual(coordinator.dismissCallCount, 1)
        XCTAssertEqual(delegate.didReceiveAuthorizationCallCount, 1)
    }

    func testPresentationControllerDidDismiss() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        coordinator.dismissResult = ()
        // Act
        viewController.presentationControllerDidDismiss(UIPresentationController(presentedViewController: UIViewController(),
                                                                                 presenting: nil))
        // Assert
        XCTAssertEqual(coordinator.didDismissCallCount, 1)
        XCTAssertEqual(delegate.didReceiveAuthorizationCallCount, 1)
    }

    private func createSUT() -> AuthPermissionViewController {
        let viewController = AuthPermissionViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.delegate = delegate

        return viewController
    }

}

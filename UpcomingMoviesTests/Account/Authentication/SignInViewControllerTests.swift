//
//  SignInViewControllerTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SignInViewControllerTests: XCTestCase {

    private var viewModel: MockSignInViewModel!
    private var coordinator: MockSignInCoordinator!
    private var delegate: MockSignInViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockSignInViewModel()
        coordinator = MockSignInCoordinator()
        delegate = MockSignInViewControllerDelegate()
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
        // Act
        viewController.loginButtonAction(())
        // Assert
        XCTAssertEqual(viewModel.startAuthorizationProcessCallCount, 1)
    }

    func testDidUpdateAuthenticationState() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        viewModel.didUpdateAuthenticationState.value = .currentlySignedIn
        // Assert
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "")], timeout: 1)
        XCTAssertEqual(delegate.didUpdateAuthenticationStateCallCount, 2)
    }

    func testShowAuthPermission() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        viewModel.showAuthPermission.send(URL(string: "www.google.com")!)
        // Assert
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "")], timeout: 1)
        XCTAssertEqual(coordinator.showAuthPermissionCallCount, 1)
    }

    func testDidReceiveAuthorizationTrue() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        viewController.authPermissionViewController(AuthPermissionViewController(), didReceiveAuthorization: true)
        // Assert
        XCTAssertEqual(viewModel.signInUserCallCount, 1)
    }

    func testDidReceiveAuthorizationFalse() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        viewController.authPermissionViewController(AuthPermissionViewController(), didReceiveAuthorization: false)
        // Assert
        XCTAssertEqual(viewModel.signInUserCallCount, 0)
    }

    private func createSUT() -> SignInViewController {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.delegate = delegate

        return viewController
    }

}

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
    private var delegate: MockAuthPermissionViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockSignInViewModel()
        coordinator = MockSignInCoordinator()
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
        viewController.perform(Selector("closeBarButtonAction"), with: nil)
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

    private func createSUT() -> SignInViewController {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.delegate = delegate

        return viewController
    }

}

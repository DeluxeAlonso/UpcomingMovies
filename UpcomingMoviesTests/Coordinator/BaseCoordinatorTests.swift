//
//  BaseCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 20/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class BaseCoordinatorTests: XCTestCase {

    private var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        try super.tearDownWithError()
    }

    func testSetupNavigationControllerDelegate() {
        // Arrange
        let coordinator = createSUT()
        coordinator.navigationController.delegate = nil
        // Act
        coordinator.setupNavigationControllerDelegate()
        // Assert
        XCTAssertNotNil(navigationController.delegate)
    }

    func testSetupNavigationControllerDelegateExistingDelegateShouldNotOverride() {
        // Arrange
        let coordinator = createSUT()
        let delegate = MockNavigationControllerDelegate()
        coordinator.navigationController.delegate = delegate
        coordinator.shouldForceDelegateOverride = false
        // Act
        coordinator.setupNavigationControllerDelegate()
        // Assert
        XCTAssertTrue(navigationController.delegate is MockNavigationControllerDelegate)
    }

    func testSetupNavigationControllerDelegateExistingDelegateShouldOverride() {
        // Arrange
        let coordinator = createSUT()
        let delegate = MockNavigationControllerDelegate()
        coordinator.navigationController.delegate = delegate
        coordinator.shouldForceDelegateOverride = true
        // Act
        coordinator.setupNavigationControllerDelegate()
        // Assert
        XCTAssertFalse(navigationController.delegate is MockNavigationControllerDelegate)
    }

    func testNavigationControllerDidShow() {
        // Arrange
        let coordinator = createSUT()
        let transitionCoordinator = MockViewControllerTransitionCoordinator()
        let viewController = MockViewController()
        transitionCoordinator.viewControllerForKeyResult = viewController

        navigationController.viewControllersResult = []
        navigationController.transitionCoordinatorResult = transitionCoordinator
        navigationController.isBeingPresentedResult = false

        let parentCoordinator = MockCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        // Act
        coordinator.navigationController(navigationController, didShow: MockViewController(), animated: true)
        // Assert
        XCTAssertEqual(parentCoordinator.childDidFinishCallCount, 1)
    }

    func testNavigationControllerDidShowViewControllerIsBeingPresentedTrue() {
        // Arrange
        let coordinator = createSUT()
        let transitionCoordinator = MockViewControllerTransitionCoordinator()
        let viewController = MockViewController()
        transitionCoordinator.viewControllerForKeyResult = viewController

        navigationController.transitionCoordinatorResult = transitionCoordinator
        navigationController.isBeingPresentedResult = true

        let parentCoordinator = MockCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        // Act
        coordinator.navigationController(navigationController, didShow: MockViewController(), animated: true)
        // Assert
        XCTAssertEqual(parentCoordinator.childDidFinishCallCount, 0)
    }

    func testNavigationControllerDidShowViewControllerContainedInStack() {
        // Arrange
        let coordinator = createSUT()
        let transitionCoordinator = MockViewControllerTransitionCoordinator()
        let viewController = MockViewController()
        transitionCoordinator.viewControllerForKeyResult = viewController

        navigationController.viewControllersResult = [viewController]
        navigationController.transitionCoordinatorResult = transitionCoordinator
        navigationController.isBeingPresentedResult = false

        let parentCoordinator = MockCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        // Act
        coordinator.navigationController(navigationController, didShow: MockViewController(), animated: true)
        // Assert
        XCTAssertEqual(parentCoordinator.childDidFinishCallCount, 0)
    }

    func testStartPushCoordinatorMode() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.start(coordinatorMode: .push)
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
    }

    func testStartPresentCoordinatorMode() {
        // Arrange
        let coordinator = createSUT()
        let presentingViewController = MockViewController()
        // Act
        coordinator.start(coordinatorMode: .present(presentingViewController: presentingViewController, configuration: nil))
        // Assert
        XCTAssertEqual(presentingViewController.presentCallCount, 1)
    }

    func testStartEmbedWithContainerViewCoordinatorMode() {
        // Arrange
        let coordinator = createSUT()
        coordinator.parentCoordinator = MockCoordinator()
        let parentViewController = MockViewController()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: containerView))
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testStartEmbedWithoutContainerViewCoordinatorMode() {
        // Arrange
        let coordinator = createSUT()
        let parentViewController = MockViewController()
        coordinator.parentCoordinator = MockCoordinator()
        // Act
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: nil))
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testDismissPushCoordinatorMode() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.start(coordinatorMode: .push)
        coordinator.dismiss()
        // Assert
        XCTAssertEqual(navigationController.popViewControllerCallCount, 1)
    }

    func testDismissPresentCoordinatorMode() {
        // Arrange
        let coordinator = createSUT()
        let presentingViewController = MockViewController()

        let viewController = MockViewController()
        navigationController.topViewControllerResult = viewController

        let parentCoordinator = MockCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        // Act
        coordinator.start(coordinatorMode: .present(presentingViewController: presentingViewController, configuration: nil))
        coordinator.dismiss()
        // Assert
        XCTAssertEqual(viewController.dismissCallCount, 1)
        XCTAssertEqual(parentCoordinator.childDidFinishCallCount, 1)
    }

    func testDismissEmbedWithoutContainerViewCoordinatorMode() {
        // Arrange
        let builtViewController = MockViewController()
        let coordinator = createSUT(buildResult: builtViewController)
        let parentViewController = MockViewController()

        let parentCoordinator = MockCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        // Act
        coordinator.start(coordinatorMode: .embed(parentViewController: parentViewController, containerView: nil))
        coordinator.dismiss()
        // Assert
        XCTAssertEqual(builtViewController.removeFromParentCallCount, 1)
        XCTAssertEqual(parentCoordinator.childDidFinishChildCoordinatorCallCount, 1)
    }

    private func createSUT(buildResult: UIViewController? = nil) -> BaseCoordinator {
        let coordinator = TestBaseCoordinator(navigationController: navigationController)
        if let buildResult {
            coordinator.buildResult = buildResult
        }
        return coordinator
    }

}

private final class TestBaseCoordinator: BaseCoordinator {

    var buildResult: UIViewController = UIViewController()
    override func build() -> UIViewController {
        buildResult
    }

}

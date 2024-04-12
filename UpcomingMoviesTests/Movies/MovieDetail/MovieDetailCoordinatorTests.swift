//
//  MovieDetailCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 1/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieDetailCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        try super.tearDownWithError()
    }

    func testBuildWithCompleteMovieInfo() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.userInterfaceHelper)
        XCTAssertNotNil(viewController.coordinator)
    }

    func testBuildWithPartialMovieInfo() {
        // Arrange
        let coordinator = createSUT(movieInfo: .partial(movieId: 1, movieTitle: "Title"))
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.userInterfaceHelper)
        XCTAssertNotNil(viewController.coordinator)
    }

    func testShowSharingOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        // Act
        coordinator.showSharingOptions(withShareTitle: "Title")
        // Assert
        XCTAssertEqual(navigationController.presentCallCount, 1)
    }

    func testShowActionSheet() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        // Act
        coordinator.showActionSheet(title: "Title", message: "message", actions: [.init(title: "action title", style: .default)])
        // Assert
        XCTAssertEqual(navigationController.presentCallCount, 1)
    }

    func testShowCreditsMovieOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        // Act
        coordinator.showMovieOption(.credits)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieCreditsCoordinatorProtocol)
    }

    func testShowReviewsMovieOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .partial(movieId: 1, movieTitle: "Title"))
        // Act
        coordinator.showMovieOption(.reviews)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieReviewsCoordinatorProtocol)
    }

    func testShowVideosMovieOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        // Act
        coordinator.showMovieOption(.trailers)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieVideosCoordinatorProtocol)
    }

    func testShowSimilarMoviesMovieOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        // Act
        coordinator.showMovieOption(.similarMovies)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieListCoordinatorProtocol)
    }

    func testEmbedMovieDetailPoster() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockMovieDetailPosterViewControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailPoster(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testEmbedMovieDetailPosterWithRenderContent() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockMovieDetailPosterViewControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailPoster(on: parentViewController, in: containerView, with: .init(movie: MockMovieProtocol()))
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testMultipleEmbedMovieDetailPosterShouldNotAddMoreThanOneChild() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockMovieDetailPosterViewControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailPoster(on: parentViewController, in: containerView)
        coordinator.embedMovieDetailPoster(on: parentViewController, in: containerView)
        coordinator.embedMovieDetailPoster(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 3)
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
    }

    func testEmbedMovieDetailTitle() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockViewController()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailTitle(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testEmbedMovieDetailTitleWithRenderContent() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockViewController()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailTitle(on: parentViewController, in: containerView, with: .init(movie: MockMovieProtocol()))
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testMultipleEmbedMovieDetailTitleShouldNotAddMoreThanOneChild() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockViewController()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailTitle(on: parentViewController, in: containerView)
        coordinator.embedMovieDetailTitle(on: parentViewController, in: containerView)
        coordinator.embedMovieDetailTitle(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 3)
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
    }

    func testEmbedMovieDetailOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockMovieDetailOptionsViewControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailOptions(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testEmbedMovieDetailOptionsWithRenderContent() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockMovieDetailOptionsViewControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailOptions(on: parentViewController, in: containerView, with: .init(options: []))
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testMultipleEmbedMovieDetailOptionsShouldNotAddMoreThanOneChild() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: MockMovieProtocol()))
        let parentViewController = MockMovieDetailOptionsViewControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        coordinator.embedMovieDetailOptions(on: parentViewController, in: containerView)
        coordinator.embedMovieDetailOptions(on: parentViewController, in: containerView)
        coordinator.embedMovieDetailOptions(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 3)
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
    }

    private func createSUT(movieInfo: MovieDetailInfo) -> MovieDetailCoordinator {
        MovieDetailCoordinator(navigationController: navigationController, movieInfo: movieInfo)
    }

}

//
//  SearchMoviesCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class SearchMoviesCoordinatorTests: XCTestCase {

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
        XCTAssertEqual(rootIdentifier, RootCoordinatorIdentifier.searchMovies)
    }

    func testBuild() {
        // Arrange
        let coordinator = createSUT()
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.coordinator)
    }

    func testEmbedSearchOptions() {
        // Arrange
        let coordinator = createSUT()
        let parentViewController = MockViewController()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        _ = coordinator.embedSearchOptions(on: parentViewController, in: containerView)
        // Assert
        XCTAssertEqual(parentViewController.addChildCallCount, 1)
    }

    func testEmbedSearchController() {
        // Arrange
        let coordinator = createSUT()
        let parentViewController = MockSearchMoviesResultControllerDelegate()
        let containerView = UIView()
        parentViewController.view.addSubview(containerView)
        // Act
        let searchController = coordinator.embedSearchController(on: parentViewController)
        guard let searchResultsController = searchController.searchResultsController as? SearchMoviesResultController else {
            XCTFail("Invalid search results controller")
            return
        }
        // Assert
        XCTAssertNotNil(searchResultsController.delegate)
    }

    func testShowMovieDetail() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.showMovieDetail(for: 1, and: "Title")
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MovieDetailCoordinatorProtocol)
    }

    func testShowMoviesByGenre() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.showMoviesByGenre(1, genreName: "Genre Name")
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is MoviesByGenreCoordinator)
    }

    func testShowPopularMovies() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.showDefaultSearchOption(.popular)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is PopularMoviesCoordinator)
    }

    func testShowTopRatedMovies() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.showDefaultSearchOption(.topRated)
        // Assert
        XCTAssertEqual(coordinator.unwrappedParentCoordinator.childCoordinators.count, 1)
        guard let childCoordinator = coordinator.unwrappedParentCoordinator.childCoordinators.first else {
            XCTFail("No child coordinator available")
            return
        }
        XCTAssertTrue(childCoordinator is TopRatedMoviesCoordinator)
    }

    private func createSUT() -> SearchMoviesCoordinator {
        SearchMoviesCoordinator(navigationController: navigationController)
    }

}

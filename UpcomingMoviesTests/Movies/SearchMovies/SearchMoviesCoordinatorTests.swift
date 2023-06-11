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

    func testStart() {
        // Arrange
        let coordinator = createSUT()
        // Act
        coordinator.start()
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
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

    private func createSUT() -> SearchMoviesCoordinator {
        SearchMoviesCoordinator(navigationController: navigationController)
    }

}

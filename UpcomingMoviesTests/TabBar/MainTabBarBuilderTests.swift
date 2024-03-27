//
//  MainTabBarBuilderTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 26/03/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MainTabBarBuilderTests: XCTestCase {

    func testCreateNavigationController() {
        // Arrange
        let title = "Title"
        let image = UIImage()
        // Act
        let navigationController = MainTabBarBuilder.createNavigationController(title: title, image: image)
        // Assert
        XCTAssertEqual(navigationController.tabBarItem.title, title)
        XCTAssertEqual(navigationController.tabBarItem.image, image)
    }

    func testBuildViewCoordinators() {
        // Act
        let coordinators = MainTabBarBuilder.buildViewCoordinators()
        // Assert
        XCTAssertEqual(coordinators.count, 3)
        XCTAssertNotNil(coordinators[0] as? UpcomingMoviesCoordinator)
        XCTAssertNotNil(coordinators[1] as? SearchMoviesCoordinator)
        XCTAssertNotNil(coordinators[2] as? AccountCoordinator)
    }

    func testRootCoordinatorIdentifier() {
        // Act
        let upcomingMoviesIdentifier = RootCoordinatorIdentifier.upcomingMovies
        let searchMoviesIdentifier = RootCoordinatorIdentifier.searchMovies
        let accountIdentifier = RootCoordinatorIdentifier.account
        // Assert
        XCTAssertEqual(upcomingMoviesIdentifier, "upcoming")
        XCTAssertEqual(searchMoviesIdentifier, "search")
        XCTAssertEqual(accountIdentifier, "account")
    }

}

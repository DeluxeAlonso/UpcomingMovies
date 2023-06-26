//
//  MovieCreditsCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieCreditsCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        try super.tearDownWithError()
    }

    func testBuild() {
        // Arrange
        let coordinator = MovieCreditsCoordinator(navigationController: navigationController, movieId: 1, movieTitle: "Title")
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.coordinator)
    }
}

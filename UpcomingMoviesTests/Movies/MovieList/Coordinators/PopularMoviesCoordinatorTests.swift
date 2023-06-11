//
//  PopularMoviesCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class PopularMoviesCoordinatorTests: XCTestCase {

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
        let coordinator = PopularMoviesCoordinator(navigationController: navigationController)
        // Act
        coordinator.start()
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
    }

}

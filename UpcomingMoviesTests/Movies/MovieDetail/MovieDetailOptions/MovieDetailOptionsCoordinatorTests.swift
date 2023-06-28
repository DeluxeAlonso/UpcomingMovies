//
//  MovieDetailOptionsCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieDetailOptionsCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!
    var delegate: MockMovieDetailOptionsViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        delegate = MockMovieDetailOptionsViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testBuild() {
        // Arrange
        let coordinator = createSUT()
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.delegate)
    }

    private func createSUT() -> MovieDetailOptionsCoordinator {
        MovieDetailOptionsCoordinator(navigationController: navigationController,
                                      renderContent: .init(options: []),
                                      delegate: delegate)
    }

}

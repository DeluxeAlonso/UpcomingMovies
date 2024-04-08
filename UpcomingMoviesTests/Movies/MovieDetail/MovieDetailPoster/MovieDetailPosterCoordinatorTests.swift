//
//  MovieDetailPosterCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieDetailPosterCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!
    var delegate: MockMovieDetailPosterViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        delegate = MockMovieDetailPosterViewControllerDelegate()
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

    private func createSUT() -> MovieDetailPosterCoordinator {
        MovieDetailPosterCoordinator(navigationController: navigationController,
                                     renderContent: .init(movie: MockMovieProtocol()),
                                     delegate: delegate)
    }

}

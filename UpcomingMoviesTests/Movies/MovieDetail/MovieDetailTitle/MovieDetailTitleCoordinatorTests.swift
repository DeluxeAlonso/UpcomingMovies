//
//  MovieDetailTitleCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieDetailTitleCoordinatorTests: XCTestCase {

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
        let coordinator = createSUT()
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.viewModel)
    }

    private func createSUT() -> MovieDetailTitleCoordinator {
        MovieDetailTitleCoordinator(navigationController: navigationController, renderContent: .init(movie: MockMovieProtocol()))
    }

}

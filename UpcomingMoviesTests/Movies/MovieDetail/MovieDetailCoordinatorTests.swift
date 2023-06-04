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

    func testStart() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
        // Act
        coordinator.start()
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
    }

    func testShowSharingOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
        // Act
        coordinator.showSharingOptions(withShareTitle: "Title")
        // Assert
        XCTAssertEqual(navigationController.presentCallCount, 1)
    }

    func testShowActionSheet() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
        // Act
        coordinator.showActionSheet(title: "Title", message: "message", actions: [.init(title: "action title", style: .default)])
        // Assert
        XCTAssertEqual(navigationController.presentCallCount, 1)
    }

    private func createSUT(movieInfo: MovieDetailInfo) -> MovieDetailCoordinator {
        MovieDetailCoordinator(navigationController: navigationController, movieInfo: movieInfo)
    }

}

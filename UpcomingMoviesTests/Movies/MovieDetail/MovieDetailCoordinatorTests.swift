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

    func testStartWithCompleteMovieInfo() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
        // Act
        coordinator.start()
        // Assert
        XCTAssertEqual(navigationController.pushViewControllerCallCount, 1)
    }

    func testStartWithPartialMovieInfo() {
        // Arrange
        let coordinator = createSUT(movieInfo: .partial(movieId: 1, movieTitle: "Title"))
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

    func testShowCreditsMovieOptions() {
        // Arrange
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
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
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
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
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
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
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
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
        let coordinator = createSUT(movieInfo: .complete(movie: .with(id: 1)))
        // Act
        coordinator.embedMovieDetailPoster(on: MovieDetailPosterViewControllerDelegate, in: <#T##UIView#>)
    }

    private func createSUT(movieInfo: MovieDetailInfo) -> MovieDetailCoordinator {
        MovieDetailCoordinator(navigationController: navigationController, movieInfo: movieInfo)
    }

}

//
//  ProfileCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 19/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class ProfileCoordinatorTests: XCTestCase {

    var navigationController: MockNavigationController!
    var delegate: MockProfileViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        delegate = MockProfileViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testBuild() {
        // Arrange
        let coordinator = createSUT(user: .with())
        // Act
        let viewController = coordinator.build()
        // Assert
        XCTAssertNotNil(viewController.delegate)
    }

    private func createSUT(user: User) -> ProfileCoordinator {
        ProfileCoordinator(navigationController: navigationController, user: user, delegate: delegate)
    }

}

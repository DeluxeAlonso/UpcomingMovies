//
//  SplashBuilderTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 25/03/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SplashBuilderTests: XCTestCase {

    func testBuildViewController() {
        // Act
        let tabBarController = SplashBuilder.buildViewController() as? UITabBarController
        let navigationController = tabBarController?.viewControllers?.first as? UINavigationController
        let splashViewController = navigationController?.viewControllers.first as? SplashViewController
        // Assert
        XCTAssertEqual(tabBarController?.viewControllers?.count, 1)
        XCTAssertEqual(navigationController?.viewControllers.count, 1)

        XCTAssertNotNil(splashViewController?.viewModel)
        XCTAssertNotNil(splashViewController?.navigationHandler)
    }

}

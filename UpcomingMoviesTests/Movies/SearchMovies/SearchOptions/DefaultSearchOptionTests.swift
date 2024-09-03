//
//  DefaultSearchOptionTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/09/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class DefaultSearchOptionTests: XCTestCase {

    func testPopularTitle() {
        // Act
        let title = DefaultSearchOption.popular.title
        // Assert
        XCTAssertEqual(title, "Popular Movies")
    }

    func testPopularSubtitle() {
        // Act
        let subtitle = DefaultSearchOption.popular.subtitle
        // Assert
        XCTAssertEqual(subtitle, "The hottest movies on the internet")
    }

    func testPopularIcon() {
        // Act
        let icon = DefaultSearchOption.popular.icon
        // Assert
        XCTAssertEqual(icon, #imageLiteral(resourceName: "Popular"))
    }

    func testTopRatedTitle() {
        // Act
        let title = DefaultSearchOption.topRated.title
        // Assert
        XCTAssertEqual(title, "Top Rated Movies")
    }

    func testTopRatedSubtitle() {
        // Act
        let subtitle = DefaultSearchOption.topRated.subtitle
        // Assert
        XCTAssertEqual(subtitle, "The top rated movies on the internet")
    }

    func testTopRatedIcon() {
        // Act
        let icon = DefaultSearchOption.topRated.icon
        // Assert
        XCTAssertEqual(icon, #imageLiteral(resourceName: "TopRated"))
    }

}

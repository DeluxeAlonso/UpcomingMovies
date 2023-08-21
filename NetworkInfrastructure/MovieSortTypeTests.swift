//
//  MovieSortTypeTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 21/08/23.
//

import XCTest
import UpcomingMoviesDomain
@testable import NetworkInfrastructure

final class MovieSortTypeTests: XCTestCase {

    func testWatchlistSortTypeCallAsFunctionCreatedAtAsc() throws {
        // Arrange
        let sortType = MovieSortType.Watchlist.createdAtAsc
        // Act
        let callAsFunctionResult = sortType()
        // Assert
        XCTAssertEqual(callAsFunctionResult, "created_at.asc")
    }

    func testWatchlistSortTypeCallAsFunctionCreatedAtDesc() throws {
        // Arrange
        let sortType = MovieSortType.Watchlist.createdAtDesc
        // Act
        let callAsFunctionResult = sortType()
        // Assert
        XCTAssertEqual(callAsFunctionResult, "created_at.desc")
    }

    func testFavoriteSortTypeCallAsFunctionCreatedAtAsc() throws {
        // Arrange
        let sortType = MovieSortType.Favorite.createdAtAsc
        // Act
        let callAsFunctionResult = sortType()
        // Assert
        XCTAssertEqual(callAsFunctionResult, "created_at.asc")
    }

    func testFavoriteSortTypeCallAsFunctionCreatedAtDesc() throws {
        // Arrange
        let sortType = MovieSortType.Favorite.createdAtDesc
        // Act
        let callAsFunctionResult = sortType()
        // Assert
        XCTAssertEqual(callAsFunctionResult, "created_at.desc")
    }

}

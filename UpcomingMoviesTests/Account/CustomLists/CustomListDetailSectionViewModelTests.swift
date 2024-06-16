//
//  CustomListDetailSectionViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 15/01/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class CustomListDetailSectionViewModelTests: XCTestCase {

    func testMovieCountText() {
        // Arrange
        let movieCountToTest = 1
        let list = MockListProtocol(movieCount: movieCountToTest)
        let viewModel = CustomListDetailSectionViewModel(list: list)
        // Act
        let movieCountText = viewModel.movieCountText
        // Assert
        XCTAssertEqual(movieCountText, "\(movieCountToTest)")
    }

    func testRatingText() {
        // Arrange
        let ratingToTest = 7.6302
        let list = MockListProtocol(averageRating: ratingToTest)
        let viewModel = CustomListDetailSectionViewModel(list: list)
        // Act
        let movieCountText = viewModel.ratingText
        // Assert
        XCTAssertEqual(movieCountText, "7.63")
    }

    func testMovieRuntimeText() {
        // Arrange
        let runtimeToTest = 65
        let list = MockListProtocol(runtime: runtimeToTest)
        let viewModel = CustomListDetailSectionViewModel(list: list)
        // Act
        let movieCountText = viewModel.runtimeText
        // Assert
        XCTAssertEqual(movieCountText, "1h 5m")
    }

    func testMovieRevenueTextMillionValue() {
        // Arrange
        let revenueToTest: Double = 484432473
        let list = MockListProtocol(revenue: revenueToTest)
        let viewModel = CustomListDetailSectionViewModel(list: list)
        // Act
        let movieRevenueText = viewModel.revenueText
        // Assert
        XCTAssertEqual(movieRevenueText, "$484.4M")
    }

    func testMovieRevenueTextThousandValue() {
        // Arrange
        let revenueToTest: Double = 7500
        let list = MockListProtocol(revenue: revenueToTest)
        let viewModel = CustomListDetailSectionViewModel(list: list)
        // Act
        let movieRevenueText = viewModel.revenueText
        // Assert
        XCTAssertEqual(movieRevenueText, "$7.5K")
    }

    func testMovieRevenueTextHundredValue() {
        // Arrange
        let revenueToTest: Double = 750
        let list = MockListProtocol(revenue: revenueToTest)
        let viewModel = CustomListDetailSectionViewModel(list: list)
        // Act
        let movieRevenueText = viewModel.revenueText
        // Assert
        XCTAssertEqual(movieRevenueText, "$750.0")
    }

}

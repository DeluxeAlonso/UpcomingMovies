//
//  MovieDetailOptionViewTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieDetailOptionViewTests: XCTestCase {

    func testOption() {
        // Arrange
        let optionToTest = MovieDetailOption.credits
        let view = MovieDetailOptionView(option: optionToTest)
        // Act
        let option = view.option
        // Assert
        XCTAssertEqual(optionToTest, option)
    }

    func testAccessibility() {
        // Arrange
        let optionToTest = MovieDetailOption.credits
        let view = MovieDetailOptionView(option: optionToTest)
        // Act
        view.awakeFromNib()
        let isAccessibilityElement = view.isAccessibilityElement
        let accessibilityLabel = view.accessibilityLabel
        // Assert
        XCTAssertTrue(isAccessibilityElement)
        XCTAssertEqual(accessibilityLabel, optionToTest.title)
    }

}

//
//  SearchMoviesResultViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 27/08/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class SearchMoviesResultViewModelTests: XCTestCase {

    private var mockInteractor: MockMovieDetailInteractor!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMovieDetailInteractor()
        mockFactory = MockMovieDetailViewFactory()
    }

    override func tearDown() {
        mockInteractor = nil
        mockFactory = nil
        super.tearDown()
    }
    
    func testScreenTitle() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        // Act
        let screenTitle = viewModelToTest.screenTitle
        // Assert
        XCTAssertEqual(screenTitle, LocalizedStrings.movieDetailTitle())
    }

    func testShareTitle() {
        // Arrange
        let titleToTest = "Title"
        let viewModelToTest = createSUT(with: 1, title: titleToTest)
        // Act
        let screenTitle = viewModelToTest.shareTitle
        // Assert
        XCTAssertEqual(screenTitle, String(format: LocalizedStrings.movieDetailShareText(), titleToTest))
    }

}

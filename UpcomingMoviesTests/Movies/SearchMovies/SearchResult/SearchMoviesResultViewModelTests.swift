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

    private var mockInteractor: MockSearchMoviesResultInteractor!

    override func setUp() {
        super.setUp()
        mockInteractor = MockSearchMoviesResultInteractor()
    }

    override func tearDown() {
        mockInteractor = nil
        super.tearDown()
    }

    func testEmptySearchResultsTitle() {
        // Arrange
        let viewModelToTest = SearchMoviesResultViewModel(interactor: mockInteractor)
        // Act
        let emptySearchResultsTitle = viewModelToTest.emptySearchResultsTitle
        // Assert
        XCTAssertEqual(emptySearchResultsTitle, "No results to show.")
    }

    func testShareTitle() {
        // Arrange
        let viewModelToTest = SearchMoviesResultViewModel(interactor: mockInteractor)
        // Act
        let recentSearchesTitle = viewModelToTest.recentSearchesTitle
        // Assert
        XCTAssertEqual(recentSearchesTitle, "Recent searches")
    }

}

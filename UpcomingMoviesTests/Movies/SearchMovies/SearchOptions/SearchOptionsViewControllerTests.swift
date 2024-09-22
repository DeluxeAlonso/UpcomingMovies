//
//  SearchOptionsViewControllerTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 22/09/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SearchOptionsViewControllerTests: XCTestCase {

    private var viewModel: MockSearchOptionsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockSearchOptionsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testDidSelectRowDefaultSearchesSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .defaultSearches
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(viewModel.getDefaultSearchSelectionCallCount, 1)
    }

    func testDidSelectRowGenresSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .genres
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(viewModel.getMovieGenreSelectionCallCount, 1)
    }

    private func createSUT() -> SearchOptionsViewController {
        let viewController = SearchOptionsViewController.instantiate()
        viewController.viewModel = viewModel

        return viewController
    }

}

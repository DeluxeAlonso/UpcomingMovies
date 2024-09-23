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

    func testDidSelectRowRecentlyVisitedSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let tableView = MockTableView()
        viewModel.sectionAtIndexResult = .recentlyVisited
        // Act
        viewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(tableView.deselectRowCallCount, 1)
    }

    func testDidSelectRowDefaultSearchesSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let tableView = MockTableView()
        viewModel.sectionAtIndexResult = .defaultSearches
        // Act
        viewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(tableView.deselectRowCallCount, 1)
        XCTAssertEqual(viewModel.getDefaultSearchSelectionCallCount, 1)
    }

    func testDidSelectRowGenresSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let tableView = MockTableView()
        viewModel.sectionAtIndexResult = .genres
        // Act
        viewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(tableView.deselectRowCallCount, 1)
        XCTAssertEqual(viewModel.getMovieGenreSelectionCallCount, 1)
    }

    func testHeightForRowRecentlyVisitedSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let tableView = MockTableView()
        viewModel.sectionAtIndexResult = .recentlyVisited
        // Act
        let height = viewController.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 140.0)
    }

    func testHeightForRowDefaultSearchesSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let tableView = MockTableView()
        viewModel.sectionAtIndexResult = .defaultSearches
        // Act
        let height = viewController.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(height, UITableView.automaticDimension)
    }

    func testHeightForRowGenresSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        let tableView = MockTableView()
        viewModel.sectionAtIndexResult = .genres
        // Act
        let height = viewController.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 50.0)
    }

    private func createSUT() -> SearchOptionsViewController {
        let viewController = SearchOptionsViewController.instantiate()
        viewController.viewModel = viewModel

        return viewController
    }

}

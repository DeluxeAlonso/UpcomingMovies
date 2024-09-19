//
//  SearchOptionsDataSourceTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 9/09/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SearchOptionsDataSourceTests: XCTestCase {

    private var dataSource: SearchOptionsDataSource!
    private var viewModel: MockSearchOptionsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockSearchOptionsViewModel()
        dataSource = SearchOptionsDataSource(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        dataSource = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testNumberOfSectionsPopulatedState() {
        // Arrange
        viewModel.viewState = .init(.populatedMovieVisits)
        // Act
        let numberOfSections = dataSource.numberOfSections(in: UITableView())
        // Assert
        XCTAssertEqual(numberOfSections, 3)
    }

    func testNumberOfSectionsEmptyState() {
        // Arrange
        viewModel.viewState = .init(.emptyMovieVisits)
        // Act
        let numberOfSections = dataSource.numberOfSections(in: UITableView())
        // Assert
        XCTAssertEqual(numberOfSections, 2)
    }

    func testTitleForHeaderInSectionPopulatedState() {
        // Arrange
        viewModel.viewState = .init(.populatedMovieVisits)
        // Act
        let title = dataSource.tableView(UITableView(), titleForHeaderInSection: 0)
        // Assert
        XCTAssertEqual(title, "Recently visited")
    }

    func testTitleForHeaderInSectionEmptyState() {
        // Arrange
        viewModel.viewState = .init(.emptyMovieVisits)
        // Act
        let title = dataSource.tableView(UITableView(), titleForHeaderInSection: 0)
        // Assert
        XCTAssertNil(title)
    }

    func testNumberOfRowsInSectionGenres() {
        // Arrange
        viewModel.sectionAtIndexResult = .genres
        viewModel.genreCells = [
            GenreSearchOptionCellViewModel(genre: GenreModel(.init(id: 1, name: "Genre 2"))),
            GenreSearchOptionCellViewModel(genre: GenreModel(.init(id: 2, name: "Genre 2")))
        ]
        // Act
        let numberOfRowsInSection = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        // Assert
        XCTAssertEqual(numberOfRowsInSection, 2)
    }

    func testNumberOfRowsInSectionDefaultSearches() {
        // Arrange
        viewModel.sectionAtIndexResult = .defaultSearches
        viewModel.defaultSearchOptionsCells = [
            DefaultSearchOptionCellViewModel(defaultSearchOption: .popular),
            DefaultSearchOptionCellViewModel(defaultSearchOption: .topRated)
        ]
        // Act
        let numberOfRowsInSection = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        // Assert
        XCTAssertEqual(numberOfRowsInSection, 2)
    }

    func testNumberOfRowsInSectionRecentlyVisited() {
        // Arrange
        viewModel.sectionAtIndexResult = .recentlyVisited
        // Act
        let numberOfRowsInSection = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        // Assert
        XCTAssertEqual(numberOfRowsInSection, 1)
    }

    func testCellForRowGenres() {
        // Arrange
        let tableView = UITableView()
        tableView.registerNib(cellType: GenreSearchOptionTableViewCell.self)
        viewModel.sectionAtIndexResult = .genres
        viewModel.genreCells = [GenreSearchOptionCellViewModel(genre: GenreModel(.init(id: 1, name: "Genre 2")))]
        // Act
        let cellForRow = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertNotNil(cellForRow as? GenreSearchOptionTableViewCell)
    }

    func testCellForRowDefaultSearches() {
        // Arrange
        let tableView = UITableView()
        tableView.register(cellType: DefaultSearchOptionTableViewCell.self)
        viewModel.sectionAtIndexResult = .defaultSearches
        viewModel.defaultSearchOptionsCells = [
            DefaultSearchOptionCellViewModel(defaultSearchOption: .popular),
            DefaultSearchOptionCellViewModel(defaultSearchOption: .topRated)
        ]
        // Act
        let cellForRow = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertNotNil(cellForRow as? DefaultSearchOptionTableViewCell)
    }

    func testCellForRowRecentlyVisited() {
        // Arrange
        let tableView = UITableView()
        tableView.registerNib(cellType: RecentlyVisitedMoviesTableViewCell.self)
        viewModel.sectionAtIndexResult = .recentlyVisited
        // Act
        let cellForRow = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertNotNil(cellForRow as? RecentlyVisitedMoviesTableViewCell)
    }

    func testDidSelectMovie() {
        // Act
        dataSource.recentlyVisitedMoviesTableViewCell(RecentlyVisitedMoviesTableViewCell(), didSelectMovieAt: IndexPath(row: 0, section: 0))
        // Assert
        XCTAssertEqual(viewModel.getRecentlyVisitedMovieSelectionCallCount, 1)
    }

}

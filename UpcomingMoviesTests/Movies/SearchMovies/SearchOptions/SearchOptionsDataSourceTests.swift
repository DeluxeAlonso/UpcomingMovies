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

}

//
//  CustomListDetailViewControllerTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 14/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class CustomListDetailViewControllerTests: XCTestCase {

    private var viewModel: MockCustomListDetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockCustomListDetailViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testViewWillAppear() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        viewController.viewWillAppear(false)
        // Assert
        XCTAssertEqual(viewController.navigationItem.scrollEdgeAppearance, viewController.navigationItem.standardAppearance)
    }

    func testHeightForHeaderInSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        let height = viewController.tableView(UITableView(), heightForHeaderInSection: 0)
        // Assert
        XCTAssertEqual(height, 60)
    }

    func testViewForHeaderInSection() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        _ = viewController.tableView(UITableView(), viewForHeaderInSection: 1)
        // Assert
        XCTAssertEqual(viewModel.buildSectionViewModelCallCount, 1)
    }

    private func createSUT() -> CustomListDetailViewController {
        let viewController = CustomListDetailViewController.instantiate()
        viewController.viewModel = viewModel

        return viewController
    }

}

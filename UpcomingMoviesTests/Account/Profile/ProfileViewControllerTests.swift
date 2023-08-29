//
//  ProfileViewControllerTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 16/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class ProfileViewControllerTests: XCTestCase {

    private var viewModel: MockProfileViewModel!
    private var coordinator: MockProfileCoordinator!
    private var delegate: MockProfileViewControllerDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockProfileViewModel()
        coordinator = MockProfileCoordinator()
        delegate = MockProfileViewControllerDelegate()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        coordinator = nil
        delegate = nil
        try super.tearDownWithError()
    }

    func testHeightForRowAtAccountInfoSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .accountInfo
        // Act
        let height = viewController.tableView(UITableView(), heightForRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(height, UITableView.automaticDimension)
    }

    func testHeightForRowAtCollectionsSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .collections
        // Act
        let height = viewController.tableView(UITableView(), heightForRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 50)
    }

    func testHeightForRowAtRecommendedSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .recommended
        // Act
        let height = viewController.tableView(UITableView(), heightForRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 50)
    }

    func testHeightForRowAtCustomListsSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .customLists
        // Act
        let height = viewController.tableView(UITableView(), heightForRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 50)
    }

    func testHeightForRowAtSignOutSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .signOut
        // Act
        let height = viewController.tableView(UITableView(), heightForRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 50)
    }

    func testHeightForRowWithoutViewModel() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewController.viewModel = nil
        // Act
        let height = viewController.tableView(UITableView(), heightForRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(height, 0)
    }

    func testDidSelectRowAtCollectionsSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .collections
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(delegate.didTapProfileOptionCallCount, 1)
    }

    func testDidSelectRowAtRecommendedSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .recommended
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(delegate.didTapProfileOptionCallCount, 1)
    }

    func testDidSelectRowAtCustomListsSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .customLists
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(delegate.didTapProfileOptionCallCount, 1)
    }

    func testDidSelectRowAtSignOutSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .signOut
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(delegate.didTapProfileOptionCallCount, 0)
    }

    func testDidSelectRowAtAccountInfoSection() throws {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        viewModel.sectionAtIndexResult = .accountInfo
        // Act
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 0, section: 0))
        // Assert
        XCTAssertEqual(delegate.didTapProfileOptionCallCount, 0)
    }

    func testDidUpdateAuthenticationState() {
        // Arrange
        let viewController = createSUT()
        _ = viewController.view
        // Act
        viewModel.didUpdateAuthenticationState.value = .currentlySignedOut
        // Assert
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "")], timeout: 1)
        XCTAssertEqual(delegate.didUpdateAuthenticationStateCallCount, 2)
    }

    private func createSUT() -> ProfileViewController {
        let viewController = ProfileViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.delegate = delegate

        return viewController
    }

}

//
//  CollapsibleCollectionHeaderViewTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 12/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class CollapsibleCollectionHeaderViewTests: XCTestCase {

    private var headerView: CollapsibleCollectionHeaderView?

    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle(for: CollapsibleCollectionHeaderView.self)
        headerView = bundle.loadNibNamed(CollapsibleCollectionHeaderView.dequeueIdentifier, owner: nil)?.first as? CollapsibleCollectionHeaderView
    }

    override func tearDownWithError() throws {
        headerView = nil
        try super.tearDownWithError()
    }

    func testTapGestureAddedOnAwakeFromNib() {
        // Assert
        XCTAssertEqual(headerView?.gestureRecognizers?.count, 1)
        XCTAssertNotNil(headerView?.gestureRecognizers?.first as? UITapGestureRecognizer)
    }

    func testTapGestureAction() {
        // Arrange
        let delegate = MockCollapsibleHeaderViewDelegate()
        headerView?.viewModel = MockCollapsibleHeaderViewModelProtocol()
        headerView?.delegate = delegate
        // Act
        headerView?.tapGestureAction()
        // Assert
        XCTAssertEqual(delegate.sectionToggledCallCount, 1)
    }

    func testTapGestureActionWithNoViewModel() {
        // Arrange
        let delegate = MockCollapsibleHeaderViewDelegate()
        headerView?.delegate = delegate
        // Act
        headerView?.tapGestureAction()
        // Assert
        XCTAssertEqual(delegate.sectionToggledCallCount, 0)
    }

    func testUpdateArrowImageView() {
        // Arrange
        let viewModel = MockCollapsibleHeaderViewModelProtocol()
        headerView?.viewModel = viewModel
        // Act
        headerView?.updateArrowImageView(animated: true)
        // Assert
        XCTAssertEqual(viewModel.arrowRotationValueCallCount, 1)
    }

    func testUpdateArrowImageViewWithoutAnimation() {
        // Arrange
        let viewModel = MockCollapsibleHeaderViewModelProtocol()
        headerView?.viewModel = viewModel
        // Act
        headerView?.updateArrowImageView(animated: false)
        // Assert
        XCTAssertEqual(viewModel.arrowRotationValueCallCount, 1)
    }

}

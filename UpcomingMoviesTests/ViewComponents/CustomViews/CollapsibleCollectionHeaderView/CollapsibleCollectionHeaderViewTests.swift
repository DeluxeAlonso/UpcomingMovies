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

    func testTapGestureAddedOnAwakeFromNib() {
        // Arrange
        let view = CollapsibleCollectionHeaderView()
        // Act
        view.awakeFromNib()
        // Assert
        XCTAssertEqual(view.gestureRecognizers?.count, 1)
        XCTAssertNotNil(view.gestureRecognizers?.first as? UITapGestureRecognizer)
    }

    func testBindablesSetup() {
        // Arrange
        let view = CollapsibleCollectionHeaderView()
        let viewModel = MockCollapsibleHeaderViewModelProtocol()
        viewModel.title = "Title"
        // Act
        view.viewModel = viewModel
        // Assert
        XCTAssertEqual(view.til, 1)
        XCTAssertNotNil(view.gestureRecognizers?.first as? UITapGestureRecognizer)
    }

}

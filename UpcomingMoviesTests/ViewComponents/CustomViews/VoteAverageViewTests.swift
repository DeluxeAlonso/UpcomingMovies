//
//  VoteAverageViewTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class VoteAverageViewTests: XCTestCase {

    func testVoteValueUpdate() {
        // Arrange
        let view = VoteAverageView()
        view.awakeFromNib()
        // Act
        view.voteValue = 1.0
        // Assert
        XCTAssertEqual(view.voteAverageLabel.text, "1.0")
    }

}

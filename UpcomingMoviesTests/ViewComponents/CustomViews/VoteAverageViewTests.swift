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

    func testVoteValue() {
        // Arrange
        let frameToTest = LoadingFooterView.recommendedFrame
        let view = LoadingFooterView()
        // Act
        let frame = view.frame
        // Assert
        XCTAssertEqual(frame, frameToTest)
    }

}

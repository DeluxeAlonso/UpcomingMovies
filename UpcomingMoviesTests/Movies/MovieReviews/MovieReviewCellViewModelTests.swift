//
//  MovieReviewCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
import UpcomingMoviesDomain
@testable import UpcomingMovies

final class MovieReviewCellViewModelTests: XCTestCase {

    func testMovieReviewCellAuthorName() {
        // Arrange
        let review = MockReviewProtocol()
        review.authorName = "Alonso"
        let viewModel = createSUT(with: review)
        // Act
        let viewModelAuthorName = viewModel.authorName
        // Assert
        XCTAssertEqual(viewModelAuthorName, "Alonso")
    }

    func testMovieReviewCellContent() {
        // Arrange
        let review = MockReviewProtocol()
        review.content = "Review content"
        let viewModel = createSUT(with: review)
        // Act
        let viewModelContent = viewModel.content
        // Assert
        XCTAssertEqual(viewModelContent, "Review content")
    }

    private func createSUT(with review: ReviewProtocol) -> MovieReviewCellViewModel {
        MovieReviewCellViewModel(review)
    }

}

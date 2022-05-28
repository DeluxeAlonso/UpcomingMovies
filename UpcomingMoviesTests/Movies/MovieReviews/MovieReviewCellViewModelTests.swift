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

class MovieReviewCellViewModelTests: XCTestCase {

    func testMovieReviewCellAuthorName() {
        // Arrange
        let authorNametoTest = "Alonso"
        let viewModel = createSUT(with: Review.with(authorName: authorNametoTest))
        // Act
        let viewModelAuthorName = viewModel.authorName
        // Assert
        XCTAssertEqual(viewModelAuthorName, authorNametoTest)
    }

    func testMovieReviewCellContent() {
        // Arrange
        let contentToTest = "Review content"
        let viewModel = createSUT(with: Review.with(content: contentToTest))
        // Act
        let viewModelContent = viewModel.content
        // Assert
        XCTAssertEqual(viewModelContent, contentToTest)
    }

    private func createSUT(with review: Review) -> MovieReviewCellViewModel {
        return MovieReviewCellViewModel(review)
    }

}

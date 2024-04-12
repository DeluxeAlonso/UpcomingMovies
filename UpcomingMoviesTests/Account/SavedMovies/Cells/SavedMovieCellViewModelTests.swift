//
//  SavedMovieCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 11/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SavedMovieCellViewModelTests: XCTestCase {

    func testTitle() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.title = "Title"
        // Act
        let viewModel = SavedMovieCellViewModel(movie)
        let title = viewModel.title
        // Assert
        XCTAssertEqual(title, "Title")
    }

    func testBackdropURL() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.backdropURL = URL(string: "www.google.com")
        // Act
        let viewModel = SavedMovieCellViewModel(movie)
        let backdropURL = viewModel.backdropURL
        // Assert
        XCTAssertEqual(backdropURL?.absoluteString, "www.google.com")
    }

}

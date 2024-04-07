//
//  UpcomingMovieCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class UpcomingMovieCellViewModelTests: XCTestCase {

    func testUpcomingMovieCellPosterURL() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.posterURL = URL(string: "www.google.com")
        // Act
        let viewModel = createSUT(with: movie)
        let viewModelPosterURL = viewModel.posterURL
        // Assert
        XCTAssertEqual(viewModelPosterURL?.absoluteString, "www.google.com")
    }

    func testUpcomingMovieCellBackdropURL() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.backdropURL = URL(string: "www.google.com")
        // Act
        let viewModel = createSUT(with: movie)
        let viewModelBackdropURL = viewModel.backdropURL
        // Assert
        XCTAssertEqual(viewModelBackdropURL?.absoluteString, "www.google.com")
    }

    private func createSUT(with movie: MovieProtocol) -> UpcomingMovieCellViewModel {
        UpcomingMovieCellViewModel(movie)
    }

}

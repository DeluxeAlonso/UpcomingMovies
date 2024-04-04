//
//  MovieListCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 27/03/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieListCellViewModelTests: XCTestCase {

    func testName() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.title = "Title"
        // Act
        let viewModel = createSUT(with: movie)
        let title = viewModel.name
        // Assert
        XCTAssertEqual("Title", title)
    }

    func testGenreName() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.genreName = "Action"
        // Act
        let viewModel = createSUT(with: movie)
        let genreName = viewModel.genreName
        // Assert
        XCTAssertEqual("Action", genreName)
    }

    func testReleaseDate() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.releaseDate = "12-12-2025"
        // Act
        let viewModel = createSUT(with: movie)
        let releaseDate = viewModel.releaseDate
        // Assert
        XCTAssertEqual("12-12-2025", releaseDate)
    }

    func testPosterURL() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.posterURL = URL(string: "www.google.com")
        // Act
        let viewModel = createSUT(with: movie)
        let posterURL = viewModel.posterURL
        // Assert
        XCTAssertEqual("www.google.com", posterURL?.absoluteString)
    }

    func testVoteAverage() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.voteAverage = 7.5
        // Act
        let viewModel = createSUT(with: movie)
        let voteAverage = viewModel.voteAverage
        // Assert
        XCTAssertEqual(7.5, voteAverage)
    }

    private func createSUT(with movie: MovieProtocol) -> MovieListCellViewModel {
        MovieListCellViewModel(movie)
    }

}

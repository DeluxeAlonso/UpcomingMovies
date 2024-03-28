//
//  MovieCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 27/03/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieCellViewModelTests: XCTestCase {

    func testName() {
        // Arrange
        let titleToTest = "Title"
        let viewModel = createSUT(with: Movie.with(title: titleToTest))
        // Act
        let title = viewModel.name
        // Assert
        XCTAssertEqual(titleToTest, title)
    }

    func testGenreName() {
        // Arrange
        let viewModel = createSUT(with: Movie.with(genreIds: [1]))
        // Act
        let genreName = viewModel.genreName
        // Assert
        XCTAssertEqual("-", genreName)//TODO: - Inject genre handler in MovieListCellViewModel
    }

    func testReleaseDate() {
        // Arrange
        let releaseDateToTest = "12-12-2025"
        let viewModel = createSUT(with: Movie.with(releaseDate: releaseDateToTest))
        // Act
        let releaseDate = viewModel.releaseDate
        // Assert
        XCTAssertEqual(releaseDateToTest, releaseDate)
    }

    func testPosterURL() {
        // Arrange
        let posterPathToTest = "/path"
        let viewModel = createSUT(with: Movie.with(posterPath: posterPathToTest))
        // Act
        let posterURL = viewModel.posterURL
        // Assert
        XCTAssertEqual(URL(string: ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString + posterPathToTest), posterURL)
    }

    func testVoteAverage() {
        // Arrange
        let voteAverageToTest = 7.5
        let viewModel = createSUT(with: Movie.with(voteAverage: voteAverageToTest))
        // Act
        let voteAverage = viewModel.voteAverage
        // Assert
        XCTAssertEqual(voteAverageToTest, voteAverage)
    }

    private func createSUT(with movie: Movie) -> MovieCellViewModel {
        MovieCellViewModel(movie)
    }

}

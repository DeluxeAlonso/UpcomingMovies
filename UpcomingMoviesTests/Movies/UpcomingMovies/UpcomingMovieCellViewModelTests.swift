//
//  UpcomingMovieCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 28/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class UpcomingMovieCellViewModelTests: XCTestCase {

    func testUpcomingMovieCellPosterURL() {
        // Arrange
        let posterPathToTest = "/poster.jpg"
        let viewModel = createSUT(with: Movie.with(backdropPath: posterPathToTest))
        // Act
        let posterURL = viewModel.posterURL
        // Assert
        XCTAssertEqual(posterURL, URL(string: ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString + posterPathToTest))
    }

    func testUpcomingMovieCellBackdropURL() {
        // Arrange
        let backdropPathToTest = "/backdrop.jpg"
        let viewModel = createSUT(with: Movie.with(backdropPath: backdropPathToTest))
        // Act
        let backdropURL = viewModel.backdropURL
        // Assert
        XCTAssertEqual(backdropURL, URL(string: ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString + backdropPathToTest))
    }

    private func createSUT(with movie: Movie) -> UpcomingMovieCellViewModel {
        return UpcomingMovieCellViewModel(movie)
    }

}

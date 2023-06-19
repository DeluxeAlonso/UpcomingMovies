//
//  MovieDetailPosterViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 29/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain
import XCTest

final class MovieDetailPosterViewModelTests: XCTestCase {

    func testMovieDetailBackdropURL() {
        // Arrange
        let backdropPathToTest = "pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"
        let renderContent = MovieDetailPosterRenderContent(movie: Movie.with(backdropPath: backdropPathToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let backdropURL = viewModelToTest.backdropURL
        // Assert
        XCTAssertEqual(backdropURL, URL(string: ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString + backdropPathToTest))
    }

    func testMovieDetailPosterURL() {
        // Arrange
        let posterPathToTest = "pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"
        let renderContent = MovieDetailPosterRenderContent(movie: Movie.with(posterPath: posterPathToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let posterURL = viewModelToTest.posterURL
        // Assert
        XCTAssertEqual(posterURL, URL(string: ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString + posterPathToTest))
    }

    private func createSUT(renderContent: MovieDetailPosterRenderContent) -> MovieDetailPosterViewModel {
        MovieDetailPosterViewModel(renderContent)
    }

}

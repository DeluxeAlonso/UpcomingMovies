//
//  MovieDetailPosterViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 29/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import XCTest

final class MovieDetailPosterViewModelTests: XCTestCase {

    func testMovieDetailBackdropURL() {
        // Arrange
        let movie = MockMovieProtocol(backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
        let renderContent = MovieDetailPosterRenderContent(movie: movie)
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let backdropURL = viewModelToTest.backdropURL
        // Assert
        XCTAssertEqual(backdropURL, URL(string: "https://image.tmdb.org/t/p/w500/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }

    func testMovieDetailPosterURL() {
        // Arrange
        let movie = MockMovieProtocol(posterURL: URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
        let renderContent = MovieDetailPosterRenderContent(movie: movie)
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let posterURL = viewModelToTest.posterURL
        // Assert
        XCTAssertEqual(posterURL, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }

    private func createSUT(renderContent: MovieDetailPosterRenderContent) -> MovieDetailPosterViewModel {
        MovieDetailPosterViewModel(renderContent)
    }

}

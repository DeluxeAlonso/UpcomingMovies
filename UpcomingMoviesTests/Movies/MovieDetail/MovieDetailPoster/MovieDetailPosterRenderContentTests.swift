//
//  MovieDetailPosterRenderContentTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain
import XCTest

final class MovieDetailPosterRenderContentTests: XCTestCase {

    func testBackdropURL() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.backdropURL = URL(string: "www.google.com")
        // Act
        let renderContent = MovieDetailPosterRenderContent(movie: movie)
        let backdropURL = renderContent.backdropURL
        // Assert
        XCTAssertEqual("www.google.com", backdropURL?.absoluteString)
    }

    func testPosterURL() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.posterURL = URL(string: "www.google.com")
        // Act
        let renderContent = MovieDetailPosterRenderContent(movie: movie)
        let posterURL = renderContent.posterURL
        // Assert
        XCTAssertEqual("www.google.com", posterURL?.absoluteString)
    }

}

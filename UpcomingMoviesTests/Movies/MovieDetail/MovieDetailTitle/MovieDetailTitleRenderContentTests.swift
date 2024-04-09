//
//  MovieDetailTitleRenderContentTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain
import XCTest

final class MovieDetailTitleRenderContentTests: XCTestCase {

    func testTitle() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.title = "Title"
        // Act
        let renderContent = MovieDetailTitleRenderContent(movie: movie)
        let title = renderContent.title
        // Assert
        XCTAssertEqual("Title", title)
    }

    func testReleaseDate() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.releaseDate = "17-04-1992"
        // Act
        let renderContent = MovieDetailTitleRenderContent(movie: movie)
        let releaseDate = renderContent.releaseDate
        // Assert
        XCTAssertEqual("17-04-1992", releaseDate)
    }

    func testVoteAverage() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.voteAverage = 5.5
        // Act
        let renderContent = MovieDetailTitleRenderContent(movie: movie)
        let voteAverage = renderContent.voteAverage
        // Assert
        XCTAssertEqual(5.5, voteAverage)
    }

    func testGenreIds() {
        // Arrange
        let movie = MockMovieProtocol()
        movie.genreIds = [1]
        // Act
        let renderContent = MovieDetailTitleRenderContent(movie: movie)
        let genreIds = renderContent.genreIds
        // Assert
        XCTAssertEqual([1], genreIds)
    }

}

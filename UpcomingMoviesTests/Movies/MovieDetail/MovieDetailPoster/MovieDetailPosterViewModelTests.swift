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

    func testMovieDetailTitle() {
        // Arrange
        let titleToTest = "Test 1"
        let renderContent = MovieDetailTitleRenderContent(movie: Movie.with(title: titleToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, titleToTest)
    }

    func testMovieDetailSubtitle() {
        // Arrange
        let releaseDateToTest = "Release Date"
        let renderContent = MovieDetailTitleRenderContent(movie: Movie.with(releaseDate: releaseDateToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let subtitle = viewModelToTest.subtitle
        // Assert
        XCTAssertEqual(subtitle, releaseDateToTest)
    }

    func testMovieDetailVoteAverage() {
        // Arrange
        let voteAverageToTest = 5.0
        let renderContent = MovieDetailTitleRenderContent(movie: Movie.with(voteAverage: voteAverageToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let voteAverage = viewModelToTest.voteAverage
        // Assert
        XCTAssertEqual(voteAverage, voteAverageToTest)
    }

    func testMovieDetailGenreIds() {
        // Arrange
        let genreIdsToTest = [1, 2, 3]
        let renderContent = MovieDetailTitleRenderContent(movie: Movie.with(genreIds: genreIdsToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let genreIds = viewModelToTest.genreIds
        // Assert
        XCTAssertEqual(genreIds, genreIdsToTest)
    }

    private func createSUT(renderContent: MovieDetailPosterRenderContent) -> MovieDetailPosterViewModel {
        MovieDetailPosterViewModel(renderContent)
    }

}

//
//  MovieDetailTitleViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 25/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import XCTest

final class MovieDetailTitleViewModelTests: XCTestCase {

    private var interactor: MovieDetailInteractorProtocol!

    override func setUp() {
        super.setUp()
        interactor = MockMovieDetailInteractor()
    }

    override func tearDown() {
        interactor = nil
        super.tearDown()
    }

    func testMovieDetailTitle() {
        // Arrange
        let titleToTest = "Test 1"
        let renderContent = MovieDetailTitleRenderContent(movie: MockMovieProtocol(title: titleToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, titleToTest)
    }

    func testMovieDetailSubtitle() {
        // Arrange
        let releaseDateToTest = "Release Date"
        let renderContent = MovieDetailTitleRenderContent(movie: MockMovieProtocol(releaseDate: releaseDateToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let subtitle = viewModelToTest.subtitle
        // Assert
        XCTAssertEqual(subtitle, releaseDateToTest)
    }

    func testMovieDetailVoteAverage() {
        // Arrange
        let voteAverageToTest = 5.0
        let renderContent = MovieDetailTitleRenderContent(movie: MockMovieProtocol(voteAverage: voteAverageToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let voteAverage = viewModelToTest.voteAverage
        // Assert
        XCTAssertEqual(voteAverage, voteAverageToTest)
    }

    func testMovieDetailGenreIds() {
        // Arrange
        let genreIdsToTest = [1, 2, 3]
        let renderContent = MovieDetailTitleRenderContent(movie: MockMovieProtocol(genreIds: genreIdsToTest))
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let genreIds = viewModelToTest.genreIds
        // Assert
        XCTAssertEqual(genreIds, genreIdsToTest)
    }

    private func createSUT(renderContent: MovieDetailTitleRenderContent) -> MovieDetailTitleViewModel {
        MovieDetailTitleViewModel(renderContent, interactor: interactor)
    }

}

//
//  MovieDetailOptionsViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 30/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain
import XCTest

final class MovieDetailOptionsViewModelTests: XCTestCase {

    func testMovieDetailOptions() {
        // Arrange
        let optionsToTest: [MovieDetailOption] = [.reviews]
        let renderContent = MovieDetailOptionsRenderContent(options: optionsToTest)
        let viewModelToTest = createSUT(renderContent: renderContent)
        // Act
        let options = viewModelToTest.options
        // Assert
        XCTAssertEqual(options, optionsToTest)
    }

    private func createSUT(renderContent: MovieDetailOptionsRenderContent) -> MovieDetailOptionsViewModel {
        MovieDetailOptionsViewModel(renderContent)
    }

}

//
//  MovieVideoCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 26/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MovieVideoCellViewModelTests: XCTestCase {

    func testNameForVideoModel() {
        // Arrange
        let nameToTest = "Video1"
        let viewModel = createSUT(with: Video.with(name: nameToTest))
        // Act
        let viewModelName = viewModel.name
        // Assert
        XCTAssertEqual(nameToTest, viewModelName)
    }

    func testThumbnailURLForVideoModel() {
        // Arrange
        let urlToTest = URL(string: "google.com")
        let viewModel = createSUT(with: Video.with(thumbnailURL: urlToTest))
        // Act
        let viewModelThumbnailURL = viewModel.thumbnailURL
        // Assert
        XCTAssertEqual(urlToTest, viewModelThumbnailURL)
    }

    // MARK: - Utils

    private func createSUT(with video: Video) -> MovieVideoCellViewModel {
        return MovieVideoCellViewModel(video)
    }

}

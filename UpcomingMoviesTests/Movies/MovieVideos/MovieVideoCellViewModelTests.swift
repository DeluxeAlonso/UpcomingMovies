//
//  MovieVideoCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 26/05/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieVideoCellViewModelTests: XCTestCase {

    func testNameForVideoModel() {
        // Arrange
        let nameToTest = "Video1"
        let viewModel = createSUT(with: MockVideoProtocol(name: nameToTest))
        // Act
        let viewModelName = viewModel.name
        // Assert
        XCTAssertEqual(nameToTest, viewModelName)
    }

    func testThumbnailURLForVideoModel() {
        // Arrange
        let urlToTest = URL(string: "google.com")
        let viewModel = createSUT(with: MockVideoProtocol(thumbnailURL: urlToTest))
        // Act
        let viewModelThumbnailURL = viewModel.thumbnailURL
        // Assert
        XCTAssertEqual(urlToTest, viewModelThumbnailURL)
    }

    private func createSUT(with video: VideoProtocol) -> MovieVideoCellViewModel {
        MovieVideoCellViewModel(video)
    }

}

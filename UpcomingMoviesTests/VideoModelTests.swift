//
//  VideoModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 26/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class VideoModelTests: XCTestCase {

    func testInitWithVideo() {
        // Arrange
        let video = Video.with(id: "12345",
                              key: "Key",
                              name: "Name",
                              site: "Site",
                              browserURL: URL(string: "www.browserURL.com"),
                              deepLinkURL: URL(string: "www.deepLinkURL.com"),
                              thumbnailURL: URL(string: "www.thumbnailURL.com"))
        // Act
        let model = VideoModel(video)
        // Assert
        XCTAssertEqual(model.id, "12345")
        XCTAssertEqual(model.key, "Key")
        XCTAssertEqual(model.name, "Name")
        XCTAssertEqual(model.site, "Site")
        XCTAssertEqual(model.browserURL?.absoluteString, "www.browserURL.com")
        XCTAssertEqual(model.deepLinkURL?.absoluteString, "www.deepLinkURL.com")
        XCTAssertEqual(model.thumbnailURL?.absoluteString, "www.thumbnailURL.com")
    }

}

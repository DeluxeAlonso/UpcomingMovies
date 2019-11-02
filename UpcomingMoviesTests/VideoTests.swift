//
//  VideoTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import Domain

class VideoTests: XCTestCase {
    
    var videoToTest: Video!

    override func setUp() {
        super.setUp()
        videoToTest = Video.with()
    }

    override func tearDown() {
        videoToTest = nil
        super.tearDown()
    }

    func testVideoBrowserURL() {
        //Act
        let browserURL = videoToTest.browserURL
        //Assert
        XCTAssertEqual(browserURL, URL(string: "https://www.youtube.com/watch?v=ABC"))
    }
    
    func testVideoDeepLinkURL() {
        //Act
        let deepLinkURL = videoToTest.deepLinkURL
        //Assert
        XCTAssertEqual(deepLinkURL, URL(string: "youtube://ABC"))
    }
    
    func testVideoThumbnailURL() {
        //Act
        let thumbnailURL = videoToTest.thumbnailURL
        //Assert
        XCTAssertEqual(thumbnailURL, URL(string: "https://img.youtube.com/vi/ABC/mqdefault.jpg"))
    }

}

//
//  MovieDetailCoordinatorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 1/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
import UIKit
@testable import UpcomingMovies

final class MovieDetailCoordinatorTests: XCTestCase {

    var coordinator: MovieDetailCoordinator!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    private func createSUT(movieInfo: MovieDetailInfo) -> MovieDetailCoordinator {
        MovieDetailCoordinator(navigationController: UINavigationController(), movieInfo: movieInfo)
    }

}

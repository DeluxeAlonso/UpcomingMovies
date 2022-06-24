//
//  MovieSearchRepositoryTests.swift
//  UpcomingMoviesData-Unit-UpcomingMoviesDataTests
//
//  Created by Alonso on 24/06/22.
//

import XCTest
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

class MovieSearchRepositoryTests: XCTestCase {

    private var repository: MovieSearchRepository!
    private var movieSearchLocalDataSource: MovieSearchLocalDataSourceProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        movieSearchLocalDataSource = MovieSearchLocalDataSourceProtocolMock()
        repository = MovieSearchRepository(localDataSource: movieSearchLocalDataSource)
    }

    override func tearDownWithError() throws {
        repository = nil
        movieSearchLocalDataSource = nil
        try super.tearDownWithError()
    }

    func testGetMovieSearches() {
        // Act
        _ = repository.getMovieSearches()
        // Assert
        XCTAssertEqual(movieSearchLocalDataSource.getMovieSearchesCallCount, 1)
    }

    func testSaveSearchTextCalled() {
        // Act
        repository.save(with: "Text")
        // Assert
        XCTAssertEqual(movieSearchLocalDataSource.saveCallCount, 1)
    }

}

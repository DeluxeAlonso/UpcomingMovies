//
//  MovieSearchRepositoryTests.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 24/06/22.
//

import XCTest
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

final class MovieSearchRepositoryTests: XCTestCase {

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
        repository.getMovieSearches(completion: { _ in })
        // Assert
        XCTAssertEqual(movieSearchLocalDataSource.getMovieSearchesCallCount, 1)
    }

    func testSaveSearchTextCalled() {
        // Act
        repository.save(with: "Text", completion: { _ in  })
        // Assert
        XCTAssertEqual(movieSearchLocalDataSource.saveCallCount, 1)
    }

}

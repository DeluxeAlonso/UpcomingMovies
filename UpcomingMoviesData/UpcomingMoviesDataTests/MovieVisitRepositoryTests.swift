//
//  MovieVisitRepositoryTests.swift
//  UpcomingMoviesData-Unit-UpcomingMoviesDataTests
//
//  Created by Alonso on 19/06/22.
//

import XCTest
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

class MovieVisitRepositoryTests: XCTestCase {

    private var repository: MovieVisitRepository!
    private var mockMovieVisitLocalDataSource: MovieVisitLocalDataSourceProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMovieVisitLocalDataSource = MovieVisitLocalDataSourceProtocolMock()
        repository = MovieVisitRepository(localDataSource: mockMovieVisitLocalDataSource)
    }

    override func tearDownWithError() throws {
        repository = nil
        mockMovieVisitLocalDataSource = nil
        try super.tearDownWithError()
    }

}

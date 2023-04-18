//
//  MovieVisitRepositoryTests.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 19/06/22.
//

import XCTest
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

final class MovieVisitRepositoryTests: XCTestCase {

    private var repository: MovieVisitRepository!
    private var movieVisitLocalDataSource: MovieVisitLocalDataSourceProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        movieVisitLocalDataSource = MovieVisitLocalDataSourceProtocolMock()
        repository = MovieVisitRepository(localDataSource: movieVisitLocalDataSource)
    }

    override func tearDownWithError() throws {
        repository = nil
        movieVisitLocalDataSource = nil
        try super.tearDownWithError()
    }

    func testGetMovieVisits() {
        // Arrange
        let movieVisitsToTest: [UpcomingMoviesDomain.MovieVisit] = [MovieVisit.with()]
        let expectation = XCTestExpectation(description: "Should get movie visits")
        // Act
        movieVisitLocalDataSource.getMovieVisitsResult = Result.success(movieVisitsToTest)
        repository.getMovieVisits { result in
            guard let movieVisits = try? result.get() else {
                XCTFail("Error while getting movie visits")
                return
            }
            XCTAssertEqual(movieVisits, movieVisitsToTest)
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(movieVisitLocalDataSource.getMovieVisitsCallCount, 1)
    }

    func testSaveMovieVisits() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get a success save result")
        // Act
        movieVisitLocalDataSource.saveResult = Result.success(())
        repository.save(with: 1, title: "", posterPath: "") { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Error while saving movie visits")
            }
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(self.movieVisitLocalDataSource.saveCallCount, 1)
    }

}

//
//  MovieDetailTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import CoreDataInfrastructure

class MovieDetailTests: XCTestCase {

    private var mockInteractor: MockMovieDetailInteractor!
    private var mockFactory: MockMovieDetailViewFactory!
    private var viewModelToTest: MovieDetailViewModelProtocol!

    override func setUp() {
        super.setUp()
        let movieToTest = Movie(id: 1,
                                title: "Test 1",
                                genreIds: [1, 2],
                                overview: "Overview",
                                posterPath: "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                                backdropPath: "/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg",
                                releaseDate: "2019-02-01", voteAverage: 4.5)
        mockInteractor = MockMovieDetailInteractor()
        mockFactory = MockMovieDetailViewFactory()
        viewModelToTest = MovieDetailViewModel(movieToTest,
                                               interactor: mockInteractor,
                                               factory: mockFactory)
    }

    override func tearDown() {
        mockInteractor = nil
        mockFactory = nil
        viewModelToTest = nil
        super.tearDown()
    }

    func testMovieDetailTitle() {
        // Act
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, "Test 1")
    }

    func testMovieDetailReleaseDate() {
        // Act
        let releaseDate = viewModelToTest.releaseDate
        // Assert
        XCTAssertEqual(releaseDate, "2019-02-01")
    }

    func testMovieDetailOverview() {
        // Act
        let overview = viewModelToTest.overview
        // Assert
        XCTAssertEqual(overview, "Overview")
    }

    func testMovieDetailVoteAverage() {
        // Act
        let voteAverage = viewModelToTest.voteAverage
        // Assert
        XCTAssertEqual(voteAverage, 4.5)
    }

    func testMovieDetailPosterPath() {
        // Act
        let fullPosterPath = viewModelToTest.posterURL
        // Assert
        XCTAssertEqual(fullPosterPath!, URL(string: "https://image.tmdb.org/t/p/w185/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"))
    }

    func testMovieDetailBackdropPath() {
        // Act
        let fullBackdropPath = viewModelToTest.backdropURL
        // Assert
        XCTAssertEqual(fullBackdropPath!, URL(string: "https://image.tmdb.org/t/p/w500/2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg"))
    }

    func testDidSetupMovieDetail() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        let expectation = XCTestExpectation(description: "didSetupMovieDetail event should be sent")
        // Act
        viewModelToTest.didSetupMovieDetail.bind { _ in
            expectation.fulfill()
        }
        mockInteractor.getMovieDetailResult = Result.success(Movie.with(id: 1))
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    private func createSUT(with movie: Movie) -> MovieDetailViewModelProtocol {
        return MovieDetailViewModel(movie,
                                    interactor: mockInteractor,
                                    factory: mockFactory)
    }

    private func createSUT(with id: Int, title: String) -> MovieDetailViewModelProtocol {
        return MovieDetailViewModel(id: id,
                                    title: title,
                                    interactor: mockInteractor,
                                    factory: mockFactory)
    }

}

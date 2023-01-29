//
//  MovieDetailViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import NetworkInfrastructure
@testable import CoreDataInfrastructure

class MovieDetailViewModelTests: XCTestCase {

    private var mockInteractor: MockMovieDetailInteractor!
    private var mockFactory: MockMovieDetailViewFactory!

    override func setUp() {
        super.setUp()
        mockInteractor = MockMovieDetailInteractor()
        mockFactory = MockMovieDetailViewFactory()
    }

    override func tearDown() {
        mockInteractor = nil
        mockFactory = nil
        super.tearDown()
    }

    func testMovieDetailTitle() {
        // Arrange
        let titleToTest = "Test 1"
        let viewModelToTest = createSUT(with: .with(title: titleToTest))
        // Act
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, titleToTest)
    }

    func testMovieDetailReleaseDate() {
        // Arrange
        let releaseDateToTest = "2019-02-01"
        let viewModelToTest = createSUT(with: .with(releaseDate: releaseDateToTest))
        // Act
        let releaseDate = viewModelToTest.releaseDate
        // Assert
        XCTAssertEqual(releaseDate, releaseDateToTest)
    }

    func testMovieDetailOverview() {
        // Arrange
        let overviewToTest = "Overview"
        let viewModelToTest = createSUT(with: .with(overview: overviewToTest))
        // Act
        let overview = viewModelToTest.overview
        // Assert
        XCTAssertEqual(overview, overviewToTest)
    }

    func testMovieDetailVoteAverage() {
        // Arrange
        let voteAverageToTest = 4.5
        let viewModelToTest = createSUT(with: .with(voteAverage: voteAverageToTest))
        // Act
        let voteAverage = viewModelToTest.voteAverage
        // Assert
        XCTAssertEqual(voteAverage, voteAverageToTest)
    }

    func testMovieDetailPosterPath() {
        // Arrange
        let posterPathToTest = "pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg"
        let viewModelToTest = createSUT(with: .with(posterPath: posterPathToTest))
        // Act
        let fullPosterPath = viewModelToTest.posterURL
        // Assert
        XCTAssertEqual(fullPosterPath, URL(string: ImageConfigurationHandler.Constants.defaultRegularImageBaseURLString + posterPathToTest))
    }

    func testMovieDetailBackdropPath() {
        // Arrange
        let backdropPathToTest = "2Ah63TIvVmZM3hzUwR5hXFg2LEk.jpg"
        let viewModelToTest = createSUT(with: .with(backdropPath: backdropPathToTest))
        // Act
        let fullBackdropPath = viewModelToTest.backdropURL
        // Assert
        XCTAssertEqual(fullBackdropPath, URL(string: ImageConfigurationHandler.Constants.defaultBackdropImageBaseURLString + backdropPathToTest))
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

    func testShowErrorRetryView() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        let expectation = XCTestExpectation(description: "didSetupMovieDetail event should be sent")
        // Act
        viewModelToTest.showErrorRetryView.bind { _ in
            expectation.fulfill()
        }
        mockInteractor.getMovieDetailResult = Result.failure(APIError.badRequest)
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Utils

    private func createSUT(with movie: UpcomingMoviesDomain.Movie) -> MovieDetailViewModelProtocol {
        MovieDetailViewModel(movie,
                             interactor: mockInteractor,
                             factory: mockFactory)
    }

    private func createSUT(with id: Int, title: String) -> MovieDetailViewModelProtocol {
        MovieDetailViewModel(id: id,
                             title: title,
                             interactor: mockInteractor,
                             factory: mockFactory)
    }

}

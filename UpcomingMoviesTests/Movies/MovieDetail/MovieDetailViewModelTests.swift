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

    func testScreenTitle() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        // Act
        let screenTitle = viewModelToTest.screenTitle
        // Assert
        XCTAssertEqual(screenTitle, LocalizedStrings.movieDetailTitle())
    }

    func testShareTitle() {
        // Arrange
        let titleToTest = "Title"
        let viewModelToTest = createSUT(with: 1, title: titleToTest)
        // Act
        let screenTitle = viewModelToTest.shareTitle
        // Assert
        XCTAssertEqual(screenTitle, String(format: LocalizedStrings.movieDetailShareText(), titleToTest))
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

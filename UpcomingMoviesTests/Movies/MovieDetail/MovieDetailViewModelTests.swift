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

    func testSaveVisitedMovie() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        // Act
        viewModelToTest.saveVisitedMovie()
        // Assert
        XCTAssertEqual(mockInteractor.saveMovieVisitCallCount, 1)
    }

    func testGetAvailableAlertActionsWithAccountStateWatchlistTrue() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: true))
        // Act
        let actions = viewModelToTest.getAvailableAlertActions()
        // Assert
        XCTAssertEqual(actions.count, 2)
        XCTAssertEqual(actions.first?.title, LocalizedStrings.movieDetailShareActionTitle())
        XCTAssertEqual(actions.last?.title, LocalizedStrings.removeFromWatchlistHint())
    }

    func testGetAvailableAlertActionsWithAccountStateWatchlistFalse() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: false))
        // Act
        let actions = viewModelToTest.getAvailableAlertActions()
        // Assert
        XCTAssertEqual(actions.count, 2)
        XCTAssertEqual(actions.first?.title, LocalizedStrings.movieDetailShareActionTitle())
        XCTAssertEqual(actions.last?.title, LocalizedStrings.addToWatchlistHint())
    }

    func testGetAvailableAlertActionsWithNoAccountState() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = nil
        // Act
        let actions = viewModelToTest.getAvailableAlertActions()
        // Assert
        XCTAssertEqual(actions.count, 1)
        XCTAssertEqual(actions.first?.title, LocalizedStrings.movieDetailShareActionTitle())
    }

    func testShareAlertAction() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = nil
        let shareAction = viewModelToTest.getAvailableAlertActions().first
        let expectation = XCTestExpectation(description: "didSelectShareAction event should be sent")
        viewModelToTest.didSelectShareAction.bind { _ in
            expectation.fulfill()
        }
        // Act
        shareAction?.action()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToWatchlistAlertActionSuccess() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: false))
        let addToWatchListAction = viewModelToTest.getAvailableAlertActions().last
        mockInteractor.addToWatchlistResult = .success(true)
        let expectation = XCTestExpectation(description: "showSuccessAlert event should be sent")
        viewModelToTest.showSuccessAlert.bind { message in
            XCTAssertEqual(message, LocalizedStrings.addToWatchlistSuccess())
            expectation.fulfill()
        }
        // Act
        addToWatchListAction?.action()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToWatchlistAlertActionError() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: false))
        let addToWatchListAction = viewModelToTest.getAvailableAlertActions().last
        let errorToTest = APIError.badRequest
        mockInteractor.addToWatchlistResult = .failure(errorToTest)
        let expectation = XCTestExpectation(description: "showErrorAlert event should be sent")
        viewModelToTest.showErrorAlert.bind { error in
            XCTAssertEqual(error.localizedDescription, errorToTest.localizedDescription)
            expectation.fulfill()
        }
        // Act
        addToWatchListAction?.action()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testRemoveFromWatchlistAlertActionSuccess() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: true))
        let removeFromWatchListAction = viewModelToTest.getAvailableAlertActions().last
        mockInteractor.removeFromWatchlistResult = .success(true)
        let expectation = XCTestExpectation(description: "showSuccessAlert event should be sent")
        viewModelToTest.showSuccessAlert.bind { message in
            XCTAssertEqual(message, LocalizedStrings.removeFromWatchlistSuccess())
            expectation.fulfill()
        }
        // Act
        removeFromWatchListAction?.action()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testRemoveFromWatchlistAlertActionError() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: true))
        let removeFromWatchListAction = viewModelToTest.getAvailableAlertActions().last
        let errorToTest = APIError.badRequest
        mockInteractor.removeFromWatchlistResult = .failure(errorToTest)
        let expectation = XCTestExpectation(description: "showErrorAlert event should be sent")
        viewModelToTest.showErrorAlert.bind { error in
            XCTAssertEqual(error.localizedDescription, errorToTest.localizedDescription)
            expectation.fulfill()
        }
        // Act
        removeFromWatchListAction?.action()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testHandleFavoriteMovieIsFavoriteNilValue() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = nil
        // Act
        viewModelToTest.handleFavoriteMovie()
        // Assert
        XCTAssertEqual(mockInteractor.markMovieAsFavoriteCallCount, 0)
    }

    func testHandleFavoriteMovieIsFavoriteTrueSuccessResponse() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: true))
        mockInteractor.markMovieAsFavoriteResult = .success(true)
        let movieAccountStateExpectation = XCTestExpectation(description: "movieAccountState event should be sent")
        let showSuccessAlertExpectation = XCTestExpectation(description: "showSuccessAlert event should be sent")
        viewModelToTest.movieAccountState.bind { newMovieAccountState in
            guard let newMovieAccountState else {
                XCTFail("newMovieAccountState cannot be nil")
                movieAccountStateExpectation.fulfill()
                return
            }
            XCTAssertFalse(newMovieAccountState.isFavorite)
            movieAccountStateExpectation.fulfill()
        }
        viewModelToTest.showSuccessAlert.bind { message in
            XCTAssertEqual(message, LocalizedStrings.removeFromFavoritesSuccess())
            showSuccessAlertExpectation.fulfill()
        }
        // Act
        viewModelToTest.handleFavoriteMovie()
        // Assert
        wait(for: [movieAccountStateExpectation, showSuccessAlertExpectation], timeout: 1.0)
    }

    func testHandleFavoriteMovieIsFavoriteTrueErrorResponse() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: true, watchlist: true))
        let errorToTest = APIError.badRequest
        mockInteractor.markMovieAsFavoriteResult = .failure(errorToTest)
        let expectation = XCTestExpectation(description: "showErrorAlert event should be sent")
        viewModelToTest.showErrorAlert.bind { error in
            XCTAssertEqual(error.localizedDescription, errorToTest.localizedDescription)
            expectation.fulfill()
        }
        // Act
        viewModelToTest.handleFavoriteMovie()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testHandleFavoriteMovieIsFavoriteFalseSuccessResponse() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: false, watchlist: true))
        mockInteractor.markMovieAsFavoriteResult = .success(true)
        let movieAccountStateExpectation = XCTestExpectation(description: "movieAccountState event should be sent")
        let showSuccessAlertExpectation = XCTestExpectation(description: "showSuccessAlert event should be sent")
        viewModelToTest.movieAccountState.bind { newMovieAccountState in
            guard let newMovieAccountState else {
                XCTFail("newMovieAccountState cannot be nil")
                movieAccountStateExpectation.fulfill()
                return
            }
            XCTAssertTrue(newMovieAccountState.isFavorite)
            movieAccountStateExpectation.fulfill()
        }
        viewModelToTest.showSuccessAlert.bind { message in
            XCTAssertEqual(message, LocalizedStrings.addToFavoritesSuccess())
            showSuccessAlertExpectation.fulfill()
        }
        // Act
        viewModelToTest.handleFavoriteMovie()
        // Assert
        wait(for: [movieAccountStateExpectation, showSuccessAlertExpectation], timeout: 1.0)
    }

    func testHandleFavoriteMovieIsFavoriteFalseErrorResponse() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        viewModelToTest.movieAccountState.value = .init(.init(favorite: false, watchlist: true))
        let errorToTest = APIError.badRequest
        mockInteractor.markMovieAsFavoriteResult = .failure(errorToTest)
        let expectation = XCTestExpectation(description: "showErrorAlert event should be sent")
        viewModelToTest.showErrorAlert.bind { error in
            XCTAssertEqual(error.localizedDescription, errorToTest.localizedDescription)
            expectation.fulfill()
        }
        // Act
        viewModelToTest.handleFavoriteMovie()
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

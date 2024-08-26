//
//  MovieDetailViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/8/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MovieDetailViewModelTests: XCTestCase {

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
        let movie = MockMovieProtocol()
        movie.title = titleToTest
        // Act
        let viewModelToTest = createSUT(with: movie)
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, titleToTest)
    }

    func testMovieDetailReleaseDate() {
        // Arrange
        let releaseDateToTest = "2019-02-01"
        let movie = MockMovieProtocol()
        movie.releaseDate = releaseDateToTest
        // Act
        let viewModelToTest = createSUT(with: movie)
        let releaseDate = viewModelToTest.releaseDate
        // Assert
        XCTAssertEqual(releaseDate, releaseDateToTest)
    }

    func testMovieDetailOverview() {
        // Arrange
        let overviewToTest = "Overview"
        let movie = MockMovieProtocol()
        movie.overview = overviewToTest
        // Act
        let viewModelToTest = createSUT(with: movie)
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
        mockInteractor.getMovieDetailResult = Result.success(MockMovieProtocol(id: 1))
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testDidSetupMovieDetailNeedsFetchFalse() {
        // Arrange
        let viewModelToTest = createSUT(with: MockMovieProtocol())
        // Act
        viewModelToTest.didSetupMovieDetail.bind { _ in
            XCTFail("didSetupMovieDetail event should not be sent")
        }
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        XCTAssertEqual(mockInteractor.getMovieDetailCallCount, 0)
    }

    func testShowErrorRetryView() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        let expectation = XCTestExpectation(description: "didSetupMovieDetail event should be sent")
        // Act
        viewModelToTest.showErrorRetryView.bind { _ in
            expectation.fulfill()
        }
        mockInteractor.getMovieDetailResult = Result.failure(TestError())
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

    func testCancelTitle() {
        // Arrange
        let viewModelToTest = createSUT(with: MockMovieProtocol())
        // Act
        let cancelTitle = viewModelToTest.cancelTitle
        // Assert
        XCTAssertEqual(cancelTitle, "Cancel")
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
        let errorToTest = TestError()
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
        let errorToTest = TestError()
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
        let errorToTest = TestError()
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
        let errorToTest = TestError()
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

    func testCheckMovieAccountStateSuccess() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        mockInteractor.isUserSignedInResult = true
        let movieAccountStateToTest = Movie.AccountState(favorite: true, watchlist: true)
        mockInteractor.getMovieAccountStateResult = .success(movieAccountStateToTest)
        let expectation = XCTestExpectation(description: "movieAccountState event should be sent")
        viewModelToTest.movieAccountState.bind { movieAccountStateModel in
            XCTAssertEqual(movieAccountStateModel?.isFavorite, movieAccountStateToTest.favorite)
            XCTAssertEqual(movieAccountStateModel?.isInWatchlist, movieAccountStateToTest.watchlist)
            expectation.fulfill()
        }
        // Act
        viewModelToTest.checkMovieAccountState()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testCheckMovieAccountStateError() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        mockInteractor.isUserSignedInResult = true
        mockInteractor.getMovieAccountStateResult = .failure(TestError())
        let expectation = XCTestExpectation(description: "movieAccountState event should be sent")
        viewModelToTest.movieAccountState.bind { movieAccountStateModel in
            XCTAssertNil(movieAccountStateModel)
            expectation.fulfill()
        }
        // Act
        viewModelToTest.checkMovieAccountState()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testCheckMovieAccountStateIsUserSignedInFalse() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        mockInteractor.isUserSignedInResult = false
        // Act
        viewModelToTest.checkMovieAccountState()
        // Assert
        XCTAssertEqual(mockInteractor.getMovieDetailCallCount, 0)
    }

    func testGetMovieGenreName() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        let genreNameToTest = "GenreName"
        mockInteractor.findGenreResult = .success(.init(id: 1, name: genreNameToTest))
        mockInteractor.getMovieDetailResult = Result.success(MockMovieProtocol(id: 1, title: "Title", genreIds: [1]))
        let expectation = XCTestExpectation(description: "showGenreName event should be sent")
        viewModelToTest.showGenreName.bind { genreName in
            XCTAssertEqual(genreName, genreNameToTest)
            expectation.fulfill()
        }
        // Act
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieGenreNameNil() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        mockInteractor.findGenreResult = .success(nil)
        mockInteractor.getMovieDetailResult = Result.success(MockMovieProtocol(id: 1, title: "Title", genreIds: [1]))
        let expectation = XCTestExpectation(description: "showGenreName event should be sent")
        viewModelToTest.showGenreName.bind { genreName in
            XCTAssertEqual(genreName, "-")
            expectation.fulfill()
        }
        // Act
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieGenreNameWihtoutId() {
        // Arrange
        let viewModelToTest = createSUT(with: 1, title: "Title")
        mockInteractor.findGenreResult = .success(nil)
        mockInteractor.getMovieDetailResult = Result.success(MockMovieProtocol(id: 1, title: "Title"))
        // Act
        viewModelToTest.getMovieDetail(showLoader: false)
        // Assert
        XCTAssertEqual(mockInteractor.findGenreCallCount, 0)
    }

    // MARK: - Utils

    private func createSUT(with movie: MockMovieProtocol) -> MovieDetailViewModelProtocol {
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

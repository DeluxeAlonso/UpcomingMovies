//
//  SearchOptionsViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class SearchOptionsViewModelTests: XCTestCase {

    private var viewModel: SearchOptionsViewModel!
    private var interactor = SearchOptionsInteractorMock()

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = SearchOptionsViewModel(interactor: interactor)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testLoadGenres() {
        // Arrange
        let genresToTest: [GenreProtocol] = [MockGenreProtocol(id: 12345, name: "Genre 1")]
        let expectation = XCTestExpectation(description: "Content reload should be called")
        // Act
        viewModel.needsContentReload.bind({ _ in
            expectation.fulfill()
        }, on: nil)
        interactor.getGenresResult = .success(genresToTest)
        viewModel.loadGenres()
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(interactor.getGenresCallCount, 1)
    }

    func testLoadVisitedMoviesFirstLoad() {
        // Arrange
        let movieVisitsToTest: [MovieVisitProtocol] = [MockMovieVisitProtocol()]
        let expectation = XCTestExpectation(description: "Content reload should be called")
        // Act
        viewModel.needsContentReload.bind({ _ in
            expectation.fulfill()
        }, on: nil)
        interactor.getMovieVisitsResult = .success(movieVisitsToTest)
        viewModel.loadVisitedMovies()
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(interactor.getMovieVisitsCallCount, 1)
    }

    func testLoadVisitedMoviesUpdate() {
        // Arrange
        let movieVisitsToTest: [MovieVisitProtocol] = [MockMovieVisitProtocol()]
        let expectation = XCTestExpectation(description: "Movie visit update should be called")
        // Act
        viewModel.updateVisitedMovies.bind({ _ in
            expectation.fulfill()
        }, on: nil)

        interactor.getMovieVisitsResult = .success(movieVisitsToTest)
        viewModel.loadVisitedMovies()

        interactor.didUpdateMovieVisit?()
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(interactor.getMovieVisitsCallCount, 2)
    }

}

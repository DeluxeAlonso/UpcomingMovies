//
//  MovieCreditsViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/5/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class MovieCreditsViewModelTests: XCTestCase {

    private var mockInteractor: MockMovieCreditsInteractor!
    private var mockFactory: MockMovieCreditsSectionManager!
    private var viewModelToTest: MovieCreditsViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockMovieCreditsInteractor()
        mockFactory = MockMovieCreditsSectionManager()

        viewModelToTest = MovieCreditsViewModel(movieId: 1, movieTitle: "Movie 1",
                                                interactor: mockInteractor, factory: mockFactory)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        mockFactory = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testMovieCreditsTitle() {
        // Act
        let title = viewModelToTest.movieTitle
        // Assert
        XCTAssertEqual(title, "Movie 1")
    }

    func testGetMovieCreditsEmpty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get empty state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .empty)
            expectation.fulfill()
        }
        mockInteractor.getMovieCreditsResult = Result.success(MockMovieCreditsProtocol(creditCast: [], creditCrew: []))
        viewModelToTest.getMovieCredits(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieCreditsPopulated() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should get populated state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .populated([MockCastProtocol(id: 1)], [MockCrewProtocol(id: 1)]))
            expectation.fulfill()
        }
        let movieCredits = MockMovieCreditsProtocol(creditCast: [MockCastProtocol(id: 1)], creditCrew: [MockCrewProtocol(id: 1)])
        mockInteractor.getMovieCreditsResult = Result.success(movieCredits)
        viewModelToTest.getMovieCredits(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMovieCreditsError() {
        // Arrange
        let errorToTest = TestError()
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.getMovieCreditsResult = Result.failure(errorToTest)
        viewModelToTest.getMovieCredits(showLoader: false)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testNumberOfSections() {
        // Arrange
        let sectionsToTest: [MovieCreditsCollapsibleSection] = [
            MovieCreditsCollapsibleSection(type: .cast, opened: true),
            MovieCreditsCollapsibleSection(type: .crew, opened: true)
        ]
        mockFactory.sections = sectionsToTest
        // Act
        let numberOfSections = viewModelToTest.numberOfSections()
        // Assert
        XCTAssertEqual(numberOfSections, sectionsToTest.count)
    }

    func testNumberOfItemsCastSection() {
        // Arrange
        let sectionsToTest: [MovieCreditsCollapsibleSection] = [
            MovieCreditsCollapsibleSection(type: .cast, opened: true),
            MovieCreditsCollapsibleSection(type: .crew, opened: true)
        ]
        mockFactory.sections = sectionsToTest

        let castToTest = [MockCastProtocol()]
        let crewToTest = [MockCrewProtocol()]
        let movieCreditsToTest = MockMovieCreditsProtocol(creditCast: castToTest, creditCrew: crewToTest)
        mockInteractor.getMovieCreditsResult = Result.success(movieCreditsToTest)
        // Act
        viewModelToTest.getMovieCredits(showLoader: false)
        let numberOfItems = viewModelToTest.numberOfItems(for: 0)
        // Assert
        XCTAssertEqual(numberOfItems, castToTest.count)
    }

    func testNumberOfItemsCrewSection() {
        // Arrange
        let sectionsToTest: [MovieCreditsCollapsibleSection] = [
            MovieCreditsCollapsibleSection(type: .cast, opened: true),
            MovieCreditsCollapsibleSection(type: .crew, opened: true)
        ]
        mockFactory.sections = sectionsToTest

        let castToTest = [MockCastProtocol()]
        let crewToTest = [MockCrewProtocol()]
        let movieCreditsToTest = MockMovieCreditsProtocol(creditCast: castToTest, creditCrew: crewToTest)
        mockInteractor.getMovieCreditsResult = Result.success(movieCreditsToTest)
        // Act
        viewModelToTest.getMovieCredits(showLoader: false)
        let numberOfItems = viewModelToTest.numberOfItems(for: 1)
        // Assert
        XCTAssertEqual(numberOfItems, crewToTest.count)
    }

    func testToggleClosedSection() {
        // Arrange
        let sectionsToTest: [MovieCreditsCollapsibleSection] = [
            MovieCreditsCollapsibleSection(type: .cast, opened: false),
            MovieCreditsCollapsibleSection(type: .crew, opened: false)
        ]
        mockFactory.sections = sectionsToTest
        let sectionIndexToTest = Int.random(in: 0...sectionsToTest.count - 1)
        let expectation = XCTestExpectation(description: "Should toggle section")
        // Act
        viewModelToTest.didToggleSection.bind { section in
            let headerModel = self.viewModelToTest.headerModel(for: section)
            XCTAssertTrue(headerModel.opened)
            expectation.fulfill()
        }
        viewModelToTest.toggleSection(sectionIndexToTest)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testToggleOpenedSection() {
        // Arrange
        let sectionsToTest: [MovieCreditsCollapsibleSection] = [
            MovieCreditsCollapsibleSection(type: .cast, opened: true),
            MovieCreditsCollapsibleSection(type: .crew, opened: true)
        ]
        mockFactory.sections = sectionsToTest
        let sectionIndexToTest = Int.random(in: 0...sectionsToTest.count - 1)
        let expectation = XCTestExpectation(description: "Should toggle section")
        // Act
        viewModelToTest.didToggleSection.bind { section in
            let headerModel = self.viewModelToTest.headerModel(for: section)
            XCTAssertFalse(headerModel.opened)
            expectation.fulfill()
        }
        viewModelToTest.toggleSection(sectionIndexToTest)
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testEmptyCreditResultsTitle() {
        // Act
        let emptyCreditResultsTitle = viewModelToTest.emptyCreditResultsTitle
        // Assert
        XCTAssertEqual(emptyCreditResultsTitle, "No credits to show.")
    }

}

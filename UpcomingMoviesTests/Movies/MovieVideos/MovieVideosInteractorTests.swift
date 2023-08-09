//
//  MovieVideosInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 1/06/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MovieVideosInteractorTests: XCTestCase {

    private var interactor: MovieVideosInteractor!
    private var mockMovieUseCase: MovieUseCaseProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMovieUseCase = MovieUseCaseProtocolMock()
        interactor = MovieVideosInteractor(movieUseCase: mockMovieUseCase)
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockMovieUseCase = nil
        try super.tearDownWithError()
    }

    func testGetMovieVideosCalled() {
        // Act
        interactor.getMovieVideos(for: 1, page: 1, completion: { _ in })
        // Assert
        XCTAssertEqual(mockMovieUseCase.getMovieVideosCallCount, 1)
    }

}

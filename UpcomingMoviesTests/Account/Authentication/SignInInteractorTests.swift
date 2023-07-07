//
//  SignInInteractorTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/07/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class SignInInteractorTests: XCTestCase {

    private var interactor: SignInInteractor!
    private var mockUserUseCase: UserUseCaseProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUserUseCase = UserUseCaseProtocolMock()
        interactor = SignInInteractor(useCaseProvider: <#T##UseCaseProviderProtocol#>)
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

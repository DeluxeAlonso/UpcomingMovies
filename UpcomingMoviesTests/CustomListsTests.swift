//
//  CustomListsTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class CustomListsTests: XCTestCase {

    typealias CustomListsState = SimpleViewState<UpcomingMoviesDomain.List>

    private var mockInteractor: MockCustomListsInteractor!
    private var viewModelToTest: CustomListsViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockCustomListsInteractor()
        viewModelToTest = CustomListsViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testGetCustomListsEmpty() {
        // Arrange
        let customListsToTest: [UpcomingMoviesDomain.List] = []
        let expectation = XCTestExpectation(description: "Should get empty state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .empty)
            expectation.fulfill()
        }
        mockInteractor.getCustomListsResult = Result.success(customListsToTest)
        viewModelToTest.getCustomLists()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListsPopulated() {
        // Arrange
        let customListsToTest: [UpcomingMoviesDomain.List] = [List.with(id: "1"), List.with(id: "2")]
        var statesToReceive: [CustomListsState] = [.paging(customListsToTest, next: 2), .populated(customListsToTest)]

        let expectation = XCTestExpectation(description: "Should get populated state after a paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, statesToReceive.removeFirst())
            expectation.fulfill()
        }
        mockInteractor.getCustomListsResult = Result.success(customListsToTest)
        viewModelToTest.getCustomLists()
        mockInteractor.getCustomListsResult = Result.success([])
        viewModelToTest.getCustomLists()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListsPaging() {
        // Arrange
        let customListsToTest: [UpcomingMoviesDomain.List] = [List.with(id: "1"), List.with(id: "2")]
        let expectation = XCTestExpectation(description: "Should get paging state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging(customListsToTest, next: 2))
            expectation.fulfill()
        }
        mockInteractor.getCustomListsResult = Result.success(customListsToTest)
        viewModelToTest.getCustomLists()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListsError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.getCustomListsResult = Result.failure(APIError.badRequest)
        viewModelToTest.getCustomLists()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}

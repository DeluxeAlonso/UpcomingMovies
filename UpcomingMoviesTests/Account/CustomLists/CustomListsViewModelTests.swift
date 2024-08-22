//
//  CustomListsViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class CustomListsViewModelTests: XCTestCase {

    typealias CustomListsState = SimpleViewState<ListProtocol>

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
        let customListsToTest: [ListProtocol] = []
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
        let customListsToTest: [ListProtocol] = [MockListProtocol(id: "1"), MockListProtocol(id: "2")]
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
        let customListsToTest: [ListProtocol] = [MockListProtocol(id: "1"), MockListProtocol(id: "2")]
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
        let errorToTest = TestError()
        let expectation = XCTestExpectation(description: "Should get error state")
        // Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(errorToTest))
            expectation.fulfill()
        }
        mockInteractor.getCustomListsResult = Result.failure(errorToTest)
        viewModelToTest.getCustomLists()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testTitle() {
        // Act
        let title = viewModelToTest.title
        // Assert
        XCTAssertEqual(title, "Created Lists")
    }

}

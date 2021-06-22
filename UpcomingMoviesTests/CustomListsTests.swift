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

        // Act
        mockInteractor.getCustomListsResult = Result.success([])
        viewModelToTest.getCustomLists()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetCustomListsPopulated() {
        // Arrange

        // Act
        mockInteractor.getCustomListsResult = Result.success([List.with(id: "1"), List.with(id: "2")])
        viewModelToTest.getCustomLists()
        mockInteractor.getCustomListsResult = Result.success([])
        viewModelToTest.getCustomLists()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([List.with(id: "1"), List.with(id: "2")]))
    }
    
    func testGetCustomListsPaging() {
        // Arrange

        // Act
        mockInteractor.getCustomListsResult = Result.success([List.with(id: "1"), List.with(id: "2")])
        viewModelToTest.getCustomLists()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .paging([List.with(id: "1"), List.with(id: "2")], next: 2))
    }
    
    func testGetCustomListsError() {
        // Arrange

        // Act
        mockInteractor.getCustomListsResult = Result.failure(APIError.badRequest)
        viewModelToTest.getCustomLists()
        // Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}

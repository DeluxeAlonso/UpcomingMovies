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
        try super.tearDownWithError()
        mockInteractor = nil
        viewModelToTest = nil
    }
    
    func testGetCustomListsEmpty() {
        //Arrange
        mockInteractor.getCustomListsResult = Result.success([])
        //Act
        viewModelToTest.getCustomLists()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }
    
    func testGetCustomListsPopulated() {
        //Arrange
        mockInteractor.getCustomListsResult = Result.success([List.with(id: "1"), List.with(id: "2")])
        //Act
        viewModelToTest.getCustomLists()
        mockInteractor.getCustomListsResult = Result.success([])
        viewModelToTest.getCustomLists()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([List.with(id: "1"), List.with(id: "2")]))
    }
    
    func testGetCustomListsPaging() {
        //Arrange
        mockInteractor.getCustomListsResult = Result.success([List.with(id: "1"), List.with(id: "2")])
        //Act
        viewModelToTest.getCustomLists()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .paging([List.with(id: "1"), List.with(id: "2")], next: 2))
    }
    
    func testGetCustomListsError() {
        //Arrange
        mockInteractor.getCustomListsResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getCustomLists()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}

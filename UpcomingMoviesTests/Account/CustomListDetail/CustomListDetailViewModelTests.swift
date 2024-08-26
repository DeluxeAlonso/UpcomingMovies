//
//  CustomListDetailViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 16/06/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

final class CustomListDetailViewModelTests: XCTestCase {

    private var interactor: MockCustomListDetailInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = MockCustomListDetailInteractor()
    }

    override func tearDownWithError() throws {
        interactor = nil
        try super.tearDownWithError()
    }

    func testListName() {
        // Arrange
        let nameToTest = "Name"
        let viewModel = createSUT(list: MockListProtocol(name: nameToTest))
        // Act
        let listName = viewModel.listName
        // Assert
        XCTAssertEqual(listName, nameToTest)
    }

    func testEmptyMovieResultsTitle() {
        // Arrange
        let viewModel = createSUT(list: MockListProtocol())
        // Act
        let emptyMovieResultsTitle = viewModel.emptyMovieResultsTitle
        // Assert
        XCTAssertEqual(emptyMovieResultsTitle, "There are no movies to show right now.")
    }

    private func createSUT(list: ListProtocol) -> CustomListDetailViewModel {
        CustomListDetailViewModel(list, interactor: interactor)
    }

}

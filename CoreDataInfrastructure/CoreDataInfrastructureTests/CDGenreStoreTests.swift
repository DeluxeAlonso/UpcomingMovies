//
//  CDGenreStoreTests.swift
//  CoreDataInfrastructureTests
//
//  Created by Alonso on 11/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import CoreDataInfrastructure
@testable import UpcomingMoviesDomain

class CDGenreStoreTests: XCTestCase {

    private var storeToTest: PersistenceStore<CDGenre>!

    override func setUp() {
        super.setUp()
        storeToTest = PersistenceStore(CoreDataStack.shared.mockPersistantContainer)
    }

    override func tearDown() {
        storeToTest = nil
        super.tearDown()
    }

    func testSaveGenre() {
        //Arrange
        let genreToTest = Genre(id: 1, name: "Action")
        let saveExpectation = XCTestExpectation(description: "Save genre")
        //Act
        storeToTest.saveGenre(genreToTest) { _ in
            let savedGenre = self.storeToTest.find(with: 1)
            XCTAssertNotNil(savedGenre)
            saveExpectation.fulfill()
        }
        //Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

    func testFindAllGenres() {
        //Arrange
        let genreToTest = Genre(id: 2, name: "Comedy")
        let saveExpectation = XCTestExpectation(description: "Save genre")
        //Act
        storeToTest.saveGenre(genreToTest) { _ in
            let allGenres = self.storeToTest.findAll()
            XCTAssertTrue(allGenres.count > 0)
            saveExpectation.fulfill()
        }
        //Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

}

//
//  CDMovieSearchStoreTests.swift
//  CoreDataInfrastructureTests
//
//  Created by Alonso on 11/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest

@testable import CoreDataInfrastructure
@testable import UpcomingMoviesDomain

class CDMovieSearchStoreTests: XCTestCase {

    private var storeToTest: PersistenceStore<CDMovieSearch>!

    override func setUp() {
        super.setUp()
        storeToTest = PersistenceStore(CoreDataStack.shared.mockPersistantContainer)
    }

    override func tearDown() {
        storeToTest = nil
        super.tearDown()
    }

    func testSaveMovieSearch() {
        //Arrange
        let saveExpectation = XCTestExpectation(description: "Save movie search")
        //Act
        storeToTest.saveMovieSearch(with: "Search") { [weak self] _ in
            guard let self = self else { return }
            let savedMovieSearch = CDMovieSearch.fetch(in: self.storeToTest.managedObjectContext).first
            XCTAssertNotNil(savedMovieSearch)
            saveExpectation.fulfill()
        }
        //Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

}

//
//  CDMovieVisitStoreTests.swift
//  CoreDataInfrastructureTests
//
//  Created by Alonso on 11/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest

@testable import CoreDataInfrastructure
@testable import UpcomingMoviesDomain
import CoreData

class CDMovieVisitStoreTests: XCTestCase {

    private var storeToTest: PersistenceStore<CDMovieVisit>!
    private var mockPersistantContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()
        mockPersistantContainer = CoreDataStack.shared.mockPersistantContainer
        storeToTest = PersistenceStore(CoreDataStack.shared.mockPersistantContainer)
    }

    override func tearDown() {
        storeToTest = nil
        mockPersistantContainer.viewContext.reset()
        super.tearDown()
    }

    func testSaveMovieVisitSuccess() {
        // Arrange
        let saveExpectation = XCTestExpectation(description: "Save movie visit")
        // Act
        storeToTest.saveMovieVisit(with: 1, title: "It", posterPath: "/poster") { _ in
            let existMovieVisit = self.storeToTest.exists()
            XCTAssertTrue(existMovieVisit)
            saveExpectation.fulfill()
        }
        // Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

    func testSaveMovieVisitError() {
        // Arrange
        let saveExpectation = XCTestExpectation(description: "Save movie visit")
        // Act
        storeToTest.saveMovieVisit(with: 1, title: "It", posterPath: nil) { _ in
            let existMovieVisit = self.storeToTest.exists()
            XCTAssertFalse(existMovieVisit)
            saveExpectation.fulfill()
        }
        // Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

}

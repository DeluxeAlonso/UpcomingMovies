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

class CDMovieVisitStoreTests: XCTestCase {
    
    private var storeToTest: PersistenceStore<CDMovieVisit>!

    override func setUp() {
        super.setUp()
        storeToTest = PersistenceStore(CoreDataStack.shared.mainContext)
    }

    override func tearDown() {
        storeToTest = nil
        super.tearDown()
    }

    func testSaveMovieSearchSuccess() {
        //Arrange
        let saveExpectation = XCTestExpectation(description: "Save movie visit")
        //Act
        storeToTest.saveMovieVisit(with: 1, title: "It", posterPath: "/poster") { _ in
            let existMovieVisit = self.storeToTest.exists()
            XCTAssertTrue(existMovieVisit)
            saveExpectation.fulfill()
        }
        //Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }
    
    func testSaveMovieSearchError() {
        //Arrange
        let saveExpectation = XCTestExpectation(description: "Save movie visit")
        //Act
        storeToTest.saveMovieVisit(with: 1, title: "It", posterPath: nil) { _ in
            let existMovieVisit = self.storeToTest.exists()
            XCTAssertFalse(existMovieVisit)
            saveExpectation.fulfill()
        }
        //Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

}

//
//  CDUserStoreTests.swift
//  CoreDataInfrastructureTests
//
//  Created by Alonso on 11/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import XCTest
@testable import CoreDataInfrastructure
@testable import UpcomingMoviesDomain

class CDUserStoreTests: XCTestCase {

    private var storeToTest: PersistenceStore<CDUser>!

    override func setUp() {
        super.setUp()
        storeToTest = PersistenceStore(CoreDataStack.shared.mockPersistantContainer)
    }

    override func tearDown() {
        storeToTest = nil
        super.tearDown()
    }

    func testSaveUser() {
        //Arrange
        let userToTest = User(id: 1, name: "Alonso", username: "DeluxeAlonso", includeAdult: true, avatarPath: nil)
        let saveExpectation = XCTestExpectation(description: "Save user")
        //Act
        storeToTest.saveUser(userToTest) { _ in
            let savedUser = self.storeToTest.find(with: 1)
            XCTAssertNotNil(savedUser)
            saveExpectation.fulfill()
        }
        //Assert
        wait(for: [saveExpectation], timeout: 1.0)
    }

}

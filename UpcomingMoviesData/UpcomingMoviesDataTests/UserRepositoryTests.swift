//
//  UserRepositoryTests.swift
//  UpcomingMoviesData-Unit-UpcomingMoviesDataTests
//
//  Created by Alonso on 8/06/22.
//

import XCTest
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

class UserRepositoryTests: XCTestCase {

    private var repository: UserRepository!
    private var mockUserLocalDataSource: UserLocalDataSourceProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockUserLocalDataSource = UserLocalDataSourceProtocolMock()
        repository = UserRepository(localDataSource: mockUserLocalDataSource)
    }

    override func tearDownWithError() throws {
        repository = nil
        mockUserLocalDataSource = nil
        try super.tearDownWithError()
    }

    func testFindUserCalled() {
        // Act
        _ = repository.find(with: 1)
        // Assert
        XCTAssertEqual(mockUserLocalDataSource.findCallCount, 1)
    }

    func testSaveserCalled() {
        // Act
        repository.saveUser(User.init(id: 1, name: "Alonso", username: "Username", includeAdult: false))
        // Assert
        XCTAssertEqual(mockUserLocalDataSource.saveUserCallCount, 1)
    }

}

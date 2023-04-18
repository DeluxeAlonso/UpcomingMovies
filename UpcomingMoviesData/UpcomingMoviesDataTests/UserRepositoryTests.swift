//
//  UserRepositoryTests.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 8/06/22.
//

import XCTest
@testable import UpcomingMoviesData
@testable import UpcomingMoviesDomain

final class UserRepositoryTests: XCTestCase {

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

    func testSaveUserCalled() {
        // Act
        repository.saveUser(User.init(id: 1, name: "Alonso", username: "Username", includeAdult: false, avatarPath: nil))
        // Assert
        XCTAssertEqual(mockUserLocalDataSource.saveUserCallCount, 1)
    }

}

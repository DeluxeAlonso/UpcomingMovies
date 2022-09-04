//
//  AccountRemoteDataSourceTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 24/08/22.
//

import XCTest
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

class AccountRemoteDataSourceTests: XCTestCase {

    var dataSource: AccountRemoteDataSource!
    var accountClient: AccountClientProtocolMock!
    var authManager: AuthenticationManagerProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        accountClient = AccountClientProtocolMock()
        authManager = AuthenticationManagerProtocolMock()
        dataSource = AccountRemoteDataSource(client: accountClient, authManager: authManager)
    }

    override func tearDownWithError() throws {
        authManager = nil
        accountClient = nil
        dataSource = nil
        try super.tearDownWithError()
    }

    func testGetFavoriteListSuccess() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "")
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getWatchlistResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies, moviesToTest.map { $0.asDomain() })
        }
        // Assert
        XCTAssertEqual(accountClient.getFavoriteListCallCount, 1)
    }

    func testGetFavoriteListFailure() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "")
        let errorToTest = APIError.badRequest
        accountClient.getWatchlistResult = .failure(errorToTest)
        // Act
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { movies in
            switch movies {
            case .success:
                XCTFail("Should throw an error")
            case .failure:
                // TODO: - Make API Error confomr to Equatable
                break
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getFavoriteListCallCount, 1)
    }

    func testGetFavoriteListNilUserAccount() throws {
        // Arrange
        authManager.userAccount = nil
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getWatchlistResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { _ in
            XCTFail("Should not be called")
        }
        // Assert
        XCTAssertEqual(accountClient.getFavoriteListCallCount, 0)
    }

}

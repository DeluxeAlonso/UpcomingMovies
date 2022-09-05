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
        accountClient.getFavoriteListResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))

        let expectation = XCTestExpectation(description: "Should get favorite list")
        // Act
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies, moviesToTest.map { $0.asDomain() })
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.getFavoriteListCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetFavoriteListFailure() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "")
        let errorToTest = APIError.badRequest
        accountClient.getFavoriteListResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { movies in
            switch movies {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getFavoriteListCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetFavoriteListNilUserAccount() throws {
        // Arrange
        authManager.userAccount = nil
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getFavoriteListResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { _ in
            XCTFail("Should not be called")
        }
        // Assert
        XCTAssertEqual(accountClient.getFavoriteListCallCount, 0)
    }

    func testGetWatchlistSuccess() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "")
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getWatchlistResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))

        let expectation = XCTestExpectation(description: "Should get watchlist")
        // Act
        dataSource.getWatchlist(page: 1, sortBy: .createdAtDesc) { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies, moviesToTest.map { $0.asDomain() })
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.getWatchlistCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetWatchlistFailure() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "")
        let errorToTest = APIError.badRequest
        accountClient.getWatchlistResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getWatchlist(page: 1, sortBy: .createdAtDesc) { movies in
            switch movies {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getWatchlistCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetWatchlistNilUserAccount() throws {
        // Arrange
        authManager.userAccount = nil
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getWatchlistResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getWatchlist(page: 1, sortBy: .createdAtDesc) { _ in
            XCTFail("Should not be called")
        }
        // Assert
        XCTAssertEqual(accountClient.getWatchlistCallCount, 0)
    }

    func testRecommendedListSuccess() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getRecommendedListResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))

        let expectation = XCTestExpectation(description: "Should get recommended list")
        // Act
        dataSource.getRecommendedList(page: 1) { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies, moviesToTest.map { $0.asDomain() })
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.getRecommendedListCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetRecommendedListFailure() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        let errorToTest = APIError.badRequest
        accountClient.getRecommendedListResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getRecommendedList(page: 1) { movies in
            switch movies {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getRecommendedListCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetRecommendedListAccountIdAndToken() throws {
        // Arrange
        authManager.accessToken = nil
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getRecommendedListResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getRecommendedList(page: 1) { _ in
            XCTFail("Should not be called")
        }
        // Assert
        XCTAssertEqual(accountClient.getRecommendedListCallCount, 0)
    }

}

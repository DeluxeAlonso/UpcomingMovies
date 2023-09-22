//
//  AccountRemoteDataSourceTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 24/08/22.
//

import XCTest
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

final class AccountRemoteDataSourceTests: XCTestCase {

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
        dataSource.getFavoriteList(page: 1, sortBy: .createdAtDesc) { _ in }
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
        dataSource.getWatchlist(page: 1, sortBy: .createdAtDesc) { _ in }
        // Assert
        XCTAssertEqual(accountClient.getWatchlistCallCount, 0)
    }

    func testGetRecommendedListSuccess() throws {
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

    func testGetRecommendedListNilAccountIdAndToken() throws {
        // Arrange
        authManager.accessToken = nil
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getRecommendedListResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getRecommendedList(page: 1) { _ in }
        // Assert
        XCTAssertEqual(accountClient.getRecommendedListCallCount, 0)
    }

    func testGetRecommendedListNilListResult() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        accountClient.getRecommendedListResult = .success(nil)
        // Act
        dataSource.getRecommendedList(page: 1) { _ in
            XCTFail("Should not receive any recommended list")
        }
        // Assert
        XCTAssertEqual(accountClient.getRecommendedListCallCount, 1)
    }

    func testGetCustomListsSuccess() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        let listToTest = [NetworkInfrastructure.List.create(id: "1")]
        accountClient.getCustomListsResult = .success(ListResult.init(results: listToTest, currentPage: 1, totalPages: 1))

        let expectation = XCTestExpectation(description: "Should get custom list")
        // Act
        dataSource.getCustomLists(page: 1) { list in
            guard let list = try? list.get() else {
                XCTFail("No valid list")
                return
            }
            XCTAssertEqual(list, listToTest.map { $0.asDomain() })
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.getCustomListsCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListFailure() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        let errorToTest = APIError.badRequest
        accountClient.getCustomListsResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getCustomLists(page: 1) { list in
            switch list {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getCustomListsCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListNilAccountIdAndToken() throws {
        // Arrange
        authManager.accessToken = nil
        let listToTest = [NetworkInfrastructure.List.create(id: "1")]
        accountClient.getCustomListsResult = .success(ListResult.init(results: listToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getCustomLists(page: 1) { _ in }
        // Assert
        XCTAssertEqual(accountClient.getCustomListsCallCount, 0)
    }

    func testGetCustomListNilListResult() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        accountClient.getCustomListsResult = .success(nil)
        // Act
        dataSource.getCustomLists(page: 1) { _ in
            XCTFail("Should not receive any custom list")
        }
        // Assert
        XCTAssertEqual(accountClient.getCustomListsCallCount, 1)
    }

    func testGetCustomListMoviesSuccess() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getCustomListMoviesResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))

        let expectation = XCTestExpectation(description: "Should get recommended list")
        // Act
        dataSource.getCustomListMovies(listId: "1") { movies in
            guard let movies = try? movies.get() else {
                XCTFail("No valid movies")
                return
            }
            XCTAssertEqual(movies, moviesToTest.map { $0.asDomain() })
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.getCustomListMoviesCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListMoviesFailure() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        let errorToTest = APIError.badRequest
        accountClient.getCustomListMoviesResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getCustomListMovies(listId: "1") { movies in
            switch movies {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getCustomListMoviesCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetCustomListMoviesNilAccessToken() throws {
        // Arrange
        authManager.accessToken = nil
        let moviesToTest = [NetworkInfrastructure.Movie.create(id: 1)]
        accountClient.getCustomListMoviesResult = .success(MovieResult.init(results: moviesToTest, currentPage: 1, totalPages: 1))
        // Act
        dataSource.getCustomListMovies(listId: "1") { _ in }
        // Assert
        XCTAssertEqual(accountClient.getCustomListMoviesCallCount, 0)
    }

    func testGetCustomListMoviesNilListResult() throws {
        // Arrange
        authManager.accessToken = .init(token: "", accountId: "")
        accountClient.getCustomListMoviesResult = .success(nil)
        // Act
        dataSource.getCustomListMovies(listId: "1") { _ in
            XCTFail("Should not receive any custom list movies")
        }
        // Assert
        XCTAssertEqual(accountClient.getCustomListMoviesCallCount, 1)
    }

    func testGetAccountDetailSuccess() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "sessionId")
        let userToTest = NetworkInfrastructure.User.create()
        accountClient.getAccountDetailResult = .success(userToTest)

        let expectation = XCTestExpectation(description: "Should get user account")
        // Act
        dataSource.getAccountDetail { user in
            guard let user = try? user.get() else {
                XCTFail("No valid user")
                return
            }
            XCTAssertEqual(user, userToTest.asDomain())
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccountDetailFailure() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "sessionId")
        let errorToTest = APIError.badRequest
        accountClient.getAccountDetailResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getAccountDetail { user in
            switch user {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccountDetailNilUserAccount() throws {
        // Arrange
        authManager.userAccount = nil
        let userToTest = NetworkInfrastructure.User.create()
        accountClient.getAccountDetailResult = .success(userToTest)
        // Act
        dataSource.getAccountDetail { _ in }
        // Assert
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 0)
    }

    func testMarkMovieAsFavoriteSuccess() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "sessionId")
        let markedAsFavorite = true
        accountClient.markAsFavoriteResult = .success(.init(statusCode: 200, statusMessage: "Success"))

        let expectation = XCTestExpectation(description: "Should get a success response for favorite marking")
        // Act
        dataSource.markMovieAsFavorite(movieId: 1, favorite: markedAsFavorite) { favorite in
            guard let favorite = try? favorite.get() else {
                XCTFail("No valid favorite marking response")
                return
            }
            XCTAssertEqual(favorite, markedAsFavorite)
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.markAsFavoriteCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testMarkMovieAsFavoriteFailure() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "sessionId")
        let errorToTest = APIError.badRequest
        accountClient.markAsFavoriteResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.markMovieAsFavorite(movieId: 1, favorite: true) { user in
            switch user {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.markAsFavoriteCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testMarkMovieAsFavoriteNilUserAccount() throws {
        // Arrange
        authManager.userAccount = nil
        accountClient.markAsFavoriteResult = .success(.init(statusCode: 200, statusMessage: "Success"))
        // Act
        dataSource.markMovieAsFavorite(movieId: 1, favorite: true) { _ in }
        // Assert
        XCTAssertEqual(accountClient.markAsFavoriteCallCount, 0)
    }

    func testAddToWatchlistSuccess() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "sessionId")
        let markedAsFavorite = true
        accountClient.addToWatchlistResult = .success(.init(statusCode: 200, statusMessage: "Success"))

        let expectation = XCTestExpectation(description: "Should get a success response for watchlist adding")
        // Act
        dataSource.addToWatchlist(movieId: 1, watchlist: markedAsFavorite) { favorite in
            guard let favorite = try? favorite.get() else {
                XCTFail("No valid watchlist adding response")
                return
            }
            XCTAssertEqual(favorite, markedAsFavorite)
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(accountClient.addToWatchlistCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToWatchlistFailure() throws {
        // Arrange
        authManager.userAccount = .init(accountId: 1, sessionId: "sessionId")
        let errorToTest = APIError.badRequest
        accountClient.addToWatchlistResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.addToWatchlist(movieId: 1, watchlist: true) { user in
            switch user {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(accountClient.addToWatchlistCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddToWatchlistNilUserAccount() throws {
        // Arrange
        authManager.userAccount = nil
        accountClient.addToWatchlistResult = .success(.init(statusCode: 200, statusMessage: "Success"))
        // Act
        dataSource.addToWatchlist(movieId: 1, watchlist: true) { _ in }
        // Assert
        XCTAssertEqual(accountClient.addToWatchlistCallCount, 0)
    }
}

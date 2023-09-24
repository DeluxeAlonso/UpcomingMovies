//
//  AuthRemoteDataSourceTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 22/09/23.
//

import XCTest
@testable import UpcomingMoviesDomain
@testable import NetworkInfrastructure

final class AuthRemoteDataSourceTests: XCTestCase {

    var dataSource: AuthRemoteDataSource!
    var authClient: AuthClientProtocolMock!
    var accountClient: AccountClientProtocolMock!
    var authManager: AuthenticationManagerProtocolMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        authClient = AuthClientProtocolMock()
        accountClient = AccountClientProtocolMock()
        authManager = AuthenticationManagerProtocolMock()
        dataSource = AuthRemoteDataSource(authClient: authClient, accountClient: accountClient, authManager: authManager)
    }

    override func tearDownWithError() throws {
        authClient = nil
        authManager = nil
        accountClient = nil
        dataSource = nil
        try super.tearDownWithError()
    }

    func testGetAuthURLSuccess() {
        // Arrange
        let tokenToTest = "123"
        authClient.getRequestTokenResult = .success(RequestTokenResult(success: true, token: tokenToTest))

        let expectation = XCTestExpectation(description: "Should get auth URL")
        // Act
        dataSource.getAuthURL { url in
            guard let url = try? url.get() else {
                XCTFail("No valid URL")
                return
            }
            XCTAssertTrue(url.absoluteString.contains(tokenToTest))
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(authClient.getRequestTokenCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAuthURLFailure() {
        // Arrange
        let errorToTest = APIError.badRequest
        authClient.getRequestTokenResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.getAuthURL { url in
            switch url {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(authClient.getRequestTokenCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInUserSuccess() {
        // Arrange
        authManager.requestToken = "123"
        let userToTest = User(id: 123, name: "", username: "", includeAdult: false, avatar: nil)
        authClient.getAccessTokenResult = .success(AccessToken(token: "123", accountId: "123"))
        authClient.createSessionIdResult = .success(SessionResult(success: true, sessionId: "123"))
        accountClient.getAccountDetailResult = .success(userToTest)

        let expectation = XCTestExpectation(description: "Should sign in user")
        // Act
        dataSource.signInUser { user in
            guard let user = try? user.get() else {
                XCTFail("No valid user")
                return
            }
            XCTAssertEqual(user.id, userToTest.id)
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(authClient.getAccessTokenCallCount, 1)
        XCTAssertEqual(authClient.createSessionIdCallCount, 1)
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 1)
        XCTAssertEqual(authManager.saveCurrentUserCallCount, 1)

        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInUserFailureInGetAccessToken() {
        // Arrange
        authManager.requestToken = "123"
        let userToTest = User(id: 123, name: "", username: "", includeAdult: false, avatar: nil)
        let errorToTest = APIError.badRequest
        authClient.getAccessTokenResult = .failure(errorToTest)
        authClient.createSessionIdResult = .success(SessionResult(success: true, sessionId: "123"))
        accountClient.getAccountDetailResult = .success(userToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.signInUser { user in
            switch user {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(authClient.getAccessTokenCallCount, 1)
        XCTAssertEqual(authClient.createSessionIdCallCount, 0)
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 0)
        XCTAssertEqual(authManager.saveCurrentUserCallCount, 0)

        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInUserFailureInCreateSessionId() {
        // Arrange
        authManager.requestToken = "123"
        let userToTest = User(id: 123, name: "", username: "", includeAdult: false, avatar: nil)
        let errorToTest = APIError.badRequest
        authClient.getAccessTokenResult = .success(AccessToken(token: "123", accountId: "123"))
        authClient.createSessionIdResult = .failure(errorToTest)
        accountClient.getAccountDetailResult = .success(userToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.signInUser { user in
            switch user {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(authClient.getAccessTokenCallCount, 1)
        XCTAssertEqual(authClient.createSessionIdCallCount, 1)
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 0)
        XCTAssertEqual(authManager.saveCurrentUserCallCount, 0)

        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInUserFailureInGetAccountDetails() {
        // Arrange
        authManager.requestToken = "123"
        let errorToTest = APIError.badRequest
        authClient.getAccessTokenResult = .success(AccessToken(token: "123", accountId: "123"))
        authClient.createSessionIdResult = .success(SessionResult(success: true, sessionId: "123"))
        accountClient.getAccountDetailResult = .failure(errorToTest)

        let expectation = XCTestExpectation(description: "Should get an error")
        // Act
        dataSource.signInUser { user in
            switch user {
            case .success:
                XCTFail("Should throw an error")
            case .failure(let error):
                XCTAssertEqual(error as? APIError, errorToTest)
                expectation.fulfill()
            }
        }
        // Assert
        XCTAssertEqual(authClient.getAccessTokenCallCount, 1)
        XCTAssertEqual(authClient.createSessionIdCallCount, 1)
        XCTAssertEqual(accountClient.getAccountDetailCallCount, 1)
        XCTAssertEqual(authManager.saveCurrentUserCallCount, 0)

        wait(for: [expectation], timeout: 1.0)
    }

    func testSignOutUser() {
        let expectation = XCTestExpectation(description: "Should sign out user")
        // Act
        dataSource.signOutUser { signedOut in
            guard let signedOut = try? signedOut.get() else {
                XCTFail("No valid user")
                return
            }
            XCTAssertEqual(signedOut, true)
            expectation.fulfill()
        }
        // Assert
        XCTAssertEqual(authManager.deleteCurrentUserCallCount, 1)

        wait(for: [expectation], timeout: 1.0)
    }

    func testCurrentUserId() {
        // Arrange
        let userIdToTest = 12345
        authManager.userAccount = Account(accountId: userIdToTest, sessionId: "12345")
        // Act
        let currentUserId = dataSource.currentUserId()
        // Assert
        XCTAssertEqual(currentUserId, userIdToTest)
    }

}

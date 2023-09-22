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
        authManager.userAccount = .init(accountId: 1, sessionId: "")
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
        authManager.userAccount = .init(accountId: 1, sessionId: "")
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
        XCTAssertEqual(accountClient.getRequestTokenCallCount, 1)
        wait(for: [expectation], timeout: 1.0)
    }

}

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

}

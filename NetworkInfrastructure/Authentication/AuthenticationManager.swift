//
//  AuthenticationManager.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    lazy var readAccessToken: String = {
        return BaseParametersHelper.shared.readAccessToken
    }()
    
    lazy var apiKey: String = {
        return BaseParametersHelper.shared.apiKey
    }()
    
    @KeychainStorage(key: Constants.sessionIdKey)
    var sessionId: String?
    
    @KeychainStorage(key: Constants.currentUserIdKey)
    var currentUserId: String?
    
    @KeychainStorage(key: Constants.accountIdKey)
    var accountId: String?
    
    @KeychainStorage(key: Constants.accessTokenKey)
    var token: String?
    
    @KeychainStorage(key: Constants.requestTokenKey)
    var requestToken: String?
    
    // MARK: - Initializers
    
    init() {}
    
    // MARK: - Public
    
    func saveCurrentUser(_ sessionId: String, accountId: Int) {
        self.sessionId = sessionId
        self.currentUserId = String(accountId)
    }
    
    func deleteCurrentUser() {
        sessionId = nil
        currentUserId = nil
        token = nil
    }
    
    // MARK: - Request Token
    
    func saveRequestToken(_ requestToken: String) {
        self.requestToken = requestToken
    }

    // MARK: - Access Token
    
    func saveAccessToken(_ accessToken: AccessToken) {
        token = accessToken.token
        accountId = accessToken.accountId
    }
    
    var accessToken: AccessToken? {
        guard let token = token,
            let accountId = accountId else {
                return nil
        }
        return AccessToken(token: token, accountId: accountId)
    }
    
    // MARK: - Credentials
    
    var userAccount: Account? {
        guard let sessionId = sessionId,
            let currentUserId = currentUserId,
            let accountId = Int(currentUserId) else {
                return nil
        }
        return Account(accountId: accountId, sessionId: sessionId)
    }
    
}

extension AuthenticationManager {
    
    struct Constants {
        static let accessTokenKey = "UpcomingMoviesAccessToken"
        static let requestTokenKey = "UpcomingMoviesRequestToken"
        static let accountIdKey = "UpcomingMoviesAccessAccountId"
        static let sessionIdKey = "UpcomingMoviesSessionId"
        static let currentUserIdKey = "UpcomingMoviesUserId"
    }
    
}

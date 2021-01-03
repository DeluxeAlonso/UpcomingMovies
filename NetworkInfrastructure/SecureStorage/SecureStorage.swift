//
//  SecureStorage.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/2/21.
//  Copyright © 2021 Alonso. All rights reserved.
//

class SecureStorage: SecureStorageProtocol {

    @KeychainStorage(key: Constants.currentUserIdKey)
    private var currentUserId: String?

    @KeychainStorage(key: Constants.accountIdKey)
    private var accountId: String?

    @KeychainStorage(key: Constants.accessTokenKey)
    private var token: String?

    @KeychainStorage(key: Constants.requestTokenKey)
    private var requestToken: String?

    init() {}

    // MARK: - SecureStorageProtocol

    func getAccessToken() -> String? {
        return token
    }

    func saveAccessToken(_ token: String?) {
        self.token = token
    }

    func getCurrentUserId() -> String? {
        return currentUserId
    }

    func saveCurrentUserId(_ currentUserId: String?) {
        self.currentUserId = currentUserId
    }

}

extension SecureStorage {

    struct Constants {
        static let accessTokenKey = "UpcomingMoviesAccessToken"
        static let requestTokenKey = "UpcomingMoviesRequestToken"
        static let accountIdKey = "UpcomingMoviesAccessAccountId"
        static let sessionIdKey = "UpcomingMoviesSessionId"
        static let currentUserIdKey = "UpcomingMoviesUserId"
    }

}

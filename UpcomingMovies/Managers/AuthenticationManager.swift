//
//  AuthenticationManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private let authUseCase: AuthUseCaseProtocol
    private let userUseCase: UserUseCaseProtocol
    
//    lazy var readAccessToken: String = {
//        let keys = retrieveKeys()
//        return keys.readAccessToken
//    }()
//
//    lazy var apiKey: String = {
//        let keys = retrieveKeys()
//        return keys.apiKey
//    }()
//
//    @KeychainStorage(key: Constants.sessionIdKey)
//    var sessionId: String?
//
//    @KeychainStorage(key: Constants.currentUserIdKey)
//    var currentUserId: String?
//
//    @KeychainStorage(key: Constants.accountIdKey)
//    var accountId: String?
//
//    @KeychainStorage(key: Constants.accessTokenKey)
//    var token: String?
    //
    // MARK: - Initializers
    
    init() {
        let useCaseProvider = InjectionFactory.useCaseProvider()
        self.authUseCase = useCaseProvider.authUseCase()
        self.userUseCase = useCaseProvider.userUseCase()
    }
    //
//    // MARK: - Public
//
//    func saveCurrentUser(_ sessionId: String, accountId: Int) {
//        self.sessionId = sessionId
//        self.currentUserId = String(accountId)
//    }
//
    func deleteCurrentUser() {
        authUseCase.signOutUser(completion: { _ in })
    }
//
//    // MARK: - Access Token
//
//    func saveAccessToken(_ accessToken: AccessToken) {
//        token = accessToken.token
//        accountId = accessToken.accountId
//    }
//
//    var accessToken: AccessToken? {
//        guard let token = token,
//            let accountId = accountId else {
//                return nil
//        }
//        return AccessToken(token: token, accountId: accountId)
//    }
//
//    // MARK: - Credentials
//
//    var userAccount: Account? {
//        guard let sessionId = sessionId,
//            let currentUserId = currentUserId,
//            let accountId = Int(currentUserId) else {
//                return nil
//        }
//        return Account(accountId: accountId, sessionId: sessionId)
//    }
    
    // MARK: - Authentitacion Persistence
    
    func currentUser() -> User? {
        guard let userId = authUseCase.currentUserId() else { return nil }
        return userUseCase.find(with: userId)
    }
    
    func isUserSignedIn() -> Bool {
        return currentUser() != nil
    }
    
//    // MARK: - TheMovieDb Keys
//
//    private func retrieveKeys() -> Keys {
//        guard let url = Bundle.main.url(forResource: "TheMovieDb",
//                                        withExtension: ".plist") else {
//                                            fatalError()
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = PropertyListDecoder()
//            let plist = try decoder.decode([String: Keys].self, from: data)
//            guard let keys = plist["Keys"] else { fatalError() }
//            return keys
//        } catch {
//            fatalError()
//        }
//    }
//
}

//extension AuthenticationManager {
//
//    struct Constants {
//        static let accessTokenKey = "UpcomingMoviesAccessToken"
//        static let accountIdKey = "UpcomingMoviesAccessAccountId"
//        static let sessionIdKey = "UpcomingMoviesSessionId"
//        static let currentUserIdKey = "UpcomingMoviesUserId"
//    }
//
//}

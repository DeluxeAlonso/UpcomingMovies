//
//  AuthRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData

final class AuthRemoteDataSource: AuthRemoteDataSourceProtocol {
    
    private let authClient: AuthClientProtocol
    private let accountClient: AccountClientProtocol
    private let authManager: AuthenticationManager
    
    init(authClient: AuthClientProtocol, accountClient: AccountClientProtocol, authManager: AuthenticationManager = AuthenticationManager.shared) {
        self.authClient = authClient
        self.accountClient = accountClient
        self.authManager = authManager
    }
    
    func getAuthURL(completion: @escaping (Result<URL, Error>) -> Void) {
        let readAccessToken = authManager.readAccessToken
        authClient.getRequestToken(with: readAccessToken) { result in
            switch result {
            case .success(let requestToken):
                guard let url = URL(string: "https://www.themoviedb.org/auth/access?request_token=\(requestToken.token)") else { return }
                self.authManager.saveRequestToken(requestToken.token)
                completion(.success(url))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signInUser(completion: @escaping (Result<UpcomingMoviesDomain.User, Error>) -> Void) {
        let readAccessToken = authManager.readAccessToken
        guard let requestToken = authManager.requestToken else { return }
        authClient.getAccessToken(with: readAccessToken, requestToken: requestToken) { result in
            switch result {
            case .success(let accessToken):
                self.authManager.saveAccessToken(accessToken)
                self.createSessionId(with: accessToken.token, completion: completion)
            case .failure(let error):
                print(error.description)
                completion(.failure(error))
            }
        }
    }
    
    private func createSessionId(with accessToken: String,
                                 completion: @escaping (Result<UpcomingMoviesDomain.User, Error>) -> Void) {
        authClient.createSessionId(with: accessToken) { result in
            switch result {
            case .success(let sessionResult):
                guard let sessionId = sessionResult.sessionId else { return }
                self.getAccountDetails(sessionId, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getAccountDetails(_ sessionId: String,
                                   completion: @escaping (Result<UpcomingMoviesDomain.User, Error>) -> Void) {
        accountClient.getAccountDetail(with: sessionId) { result in
            switch result {
            case .success(let user):
                self.authManager.saveCurrentUser(sessionId,
                                                 accountId: user.id)
                completion(.success(user.asDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signOutUser(completion: @escaping (Result<Bool, Error>) -> Void) {
        authManager.deleteCurrentUser()
        completion(.success(true))
    }
    
    func currentUserId() -> Int? {
        guard let account = authManager.userAccount else { return nil }
        return account.accountId
    }
    
}

//
//  AccountRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData

final class AccountRemoteDataSource: AccountRemoteDataSourceProtocol {
    
    private let client: AccountClient
    private let authManager: AuthenticationManager
    
    init(client: AccountClient, authManager: AuthenticationManager = AuthenticationManager.shared) {
        self.client = client
        self.authManager = authManager
    }
    
    func getCollectionList(option: ProfileCollectionOption, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.getCollectionList(page: page ?? 1, option: option, sessionId: account.sessionId, accountId: account.accountId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                completion(.success(movieResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getCustomLists(groupOption: ProfileGroupOption, page: Int?, completion: @escaping (Result<[List], Error>) -> Void) {
        guard let account = authManager.userAccount,
            let accessToken = authManager.accessToken?.token else {
            return
        }
        let accountId = String(account.accountId)
        client.getCustomLists(page: page ?? 1, groupOption: groupOption, accessToken: accessToken, accountId: accountId, completion: { result in
            switch result {
            case .success(let listResult):
                guard let listResult = listResult else { return }
                completion(.success(listResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let accessToken = authManager.accessToken?.token else { return }
        client.getCustomListMovies(with: accessToken, listId: listId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                completion(.success(movieResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.getAccountDetail(with: account.sessionId, completion: { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.markAsFavorite(movieId, sessionId: account.sessionId, accountId: account.accountId, favorite: favorite, completion: { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

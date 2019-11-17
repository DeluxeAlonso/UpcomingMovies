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
    
    init(client: AccountClient) {
        self.client = client
    }
    
    func markMovieAsFavorite(movieId: Int, favorite: Bool, account: Account, completion: @escaping (Result<Bool, Error>) -> Void) {
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

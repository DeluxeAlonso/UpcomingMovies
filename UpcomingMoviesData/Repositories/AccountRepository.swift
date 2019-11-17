//
//  AccountRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public final class AccountRepository: AccountUseCaseProtocol {
    
    private var remoteDataSource: AccountRemoteDataSourceProtocol
    
    init(remoteDataSource: AccountRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func markMovieAsFavorite(movieId: Int, favorite: Bool, account: Account, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.markMovieAsFavorite(movieId: movieId,
                                             favorite: favorite,
                                             account: account,
                                             completion: completion)
    }
    
}

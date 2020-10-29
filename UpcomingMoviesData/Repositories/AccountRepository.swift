//
//  AccountRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class AccountRepository: AccountUseCaseProtocol {
    
    private var remoteDataSource: AccountRemoteDataSourceProtocol
    
    init(remoteDataSource: AccountRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getFavoriteList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getFavoriteList(page: page,
                                         completion: completion)
    }
    
    public func getWatchList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getWatchList(page: page,
                                      completion: completion)
    }
    
    public func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void) {
        remoteDataSource.getCustomLists(page: page,
                                        completion: completion)
    }
    
    public func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getCustomListMovies(listId: listId,
                                             completion: completion)
    }
    
    public func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        remoteDataSource.getAccountDetail(completion: completion)
    }
    
    public func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.markMovieAsFavorite(movieId: movieId,
                                             favorite: favorite,
                                             completion: completion)
    }
    
}

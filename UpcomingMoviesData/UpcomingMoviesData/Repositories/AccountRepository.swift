//
//  AccountRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class AccountRepository: AccountUseCaseProtocol {
    
    private var remoteDataSource: AccountRemoteDataSourceProtocol

    // MARK: - Initializers
    
    init(remoteDataSource: AccountRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - AccountUseCaseProtocol
    
    func getFavoriteList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getFavoriteList(page: page, completion: completion)
    }
    
    func getWatchList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getWatchList(page: page, completion: completion)
    }

    func getRecommendedList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getRecommendedList(page: page, completion: completion)
    }
    
    func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void) {
        remoteDataSource.getCustomLists(page: page, completion: completion)
    }
    
    func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getCustomListMovies(listId: listId, completion: completion)
    }
    
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        remoteDataSource.getAccountDetail(completion: completion)
    }
    
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.markMovieAsFavorite(movieId: movieId, favorite: favorite, completion: completion)
    }
    
}

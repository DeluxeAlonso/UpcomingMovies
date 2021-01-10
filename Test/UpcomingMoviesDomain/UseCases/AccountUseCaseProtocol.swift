//
//  AccountUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol AccountUseCaseProtocol {
    
    func getFavoriteList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getWatchList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void)
    
    func getCustomListMovies(listId: String,
                             completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)
    
    func markMovieAsFavorite(movieId: Int,
                             favorite: Bool,
                             completion: @escaping (Result<Bool, Error>) -> Void)
    
}

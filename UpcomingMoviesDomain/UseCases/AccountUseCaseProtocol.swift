//
//  AccountUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public protocol AccountUseCaseProtocol {
    
    func getCollectionList(option: ProfileCollectionOption, page: Int?,
                           completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getCustomLists(groupOption: ProfileGroupOption, page: Int?,
                        completion: @escaping (Result<[List], Error>) -> Void)
    
    func getCustomListMovies(listId: String,
                             completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)
    
    func markMovieAsFavorite(movieId: Int,
                             favorite: Bool,
                             completion: @escaping (Result<Bool, Error>) -> Void)
    
}

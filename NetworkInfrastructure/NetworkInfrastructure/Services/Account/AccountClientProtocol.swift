//
//  AccountClientProtocol.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/23/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

protocol AccountClientProtocol {

    func getFavoriteList(page: Int, sessionId: String, accountId: Int,
                         completion: @escaping (Result<MovieResult?, APIError>) -> Void)

    func getWatchList(page: Int, sessionId: String, accountId: Int,
                      completion: @escaping (Result<MovieResult?, APIError>) -> Void)

    func getCustomLists(page: Int,
                        accessToken: String, accountId: String,
                        completion: @escaping (Result<ListResult?, APIError>) -> Void)

    func getCustomListMovies(with accessToken: String, listId: String,
                             completion: @escaping (Result<MovieResult?, APIError>) -> Void)

    func getAccountDetail(with sessionId: String,
                          completion: @escaping (Result<User, APIError>) -> Void)

    func markAsFavorite(_ movieId: Int, sessionId: String,
                        accountId: Int, favorite: Bool,
                        completion: @escaping (Result<MarkAsFavoriteResult, APIError>) -> Void)

}

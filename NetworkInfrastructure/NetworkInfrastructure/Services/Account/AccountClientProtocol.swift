//
//  AccountClientProtocol.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/23/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol AccountClientProtocol {

    func getFavoriteList(page: Int, sortBy: MovieSortType.Favorite, sessionId: String, accountId: Int,
                         completion: @escaping (Result<MovieResult?, APIError>) -> Void)

    func getWatchlist(page: Int, sortBy: MovieSortType.Watchlist, sessionId: String, accountId: Int,
                      completion: @escaping (Result<MovieResult?, APIError>) -> Void)

    func getRecommendedList(page: Int,
                            accessToken: String, accountId: String,
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

    func addToWatchlist(_ movieId: Int, sessionId: String,
                        accountId: Int, watchlist: Bool,
                        completion: @escaping (Result<AddToWatchlistResult, APIError>) -> Void)

}

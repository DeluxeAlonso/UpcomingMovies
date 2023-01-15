//
//  AccountRemoteDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol AccountRemoteDataSourceProtocol: AnyObject {

    func getFavoriteList(page: Int?, sortBy: MovieSortType.Favorite, completion: @escaping (Result<[Movie], Error>) -> Void)

    func getWatchlist(page: Int?, sortBy: MovieSortType.Watchlist, completion: @escaping (Result<[Movie], Error>) -> Void)

    func getRecommendedList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)

    func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void)

    func getCustomListMovies(listId: String,
                             completion: @escaping (Result<[Movie], Error>) -> Void)

    func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void)

    func markMovieAsFavorite(movieId: Int,
                             favorite: Bool,
                             completion: @escaping (Result<Bool, Error>) -> Void)

    func addToWatchlist(movieId: Int,
                        watchlist: Bool,
                        completion: @escaping (Result<Bool, Error>) -> Void)

}

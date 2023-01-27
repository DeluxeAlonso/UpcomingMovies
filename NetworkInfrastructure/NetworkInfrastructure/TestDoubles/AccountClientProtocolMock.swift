//
//  AccountClientProtocolMock.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 31/08/22.
//

import UpcomingMoviesDomain

final class AccountClientProtocolMock: AccountClientProtocol {

    var getFavoriteListResult: Result<MovieResult?, APIError>?
    private(set) var getFavoriteListCallCount = 0
    func getFavoriteList(page: Int,
                         sortBy: MovieSortType.Favorite,
                         sessionId: String,
                         accountId: Int,
                         completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getFavoriteListResult = getFavoriteListResult {
            completion(getFavoriteListResult)
        }
        getFavoriteListCallCount += 1
    }

    var getWatchlistResult: Result<MovieResult?, APIError>?
    private(set) var getWatchlistCallCount = 0
    func getWatchlist(page: Int,
                      sortBy: MovieSortType.Watchlist,
                      sessionId: String,
                      accountId: Int,
                      completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getWatchlistResult = getWatchlistResult {
            completion(getWatchlistResult)
        }
        getWatchlistCallCount += 1
    }

    var getRecommendedListResult: Result<MovieResult?, APIError>?
    private(set) var getRecommendedListCallCount = 0
    func getRecommendedList(page: Int,
                            accessToken: String,
                            accountId: String,
                            completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getRecommendedListResult = getRecommendedListResult {
            completion(getRecommendedListResult)
        }
        getRecommendedListCallCount += 1
    }

    var getCustomListsResult: Result<ListResult?, APIError>?
    private(set) var getCustomListsCallCount = 0
    func getCustomLists(page: Int,
                        accessToken: String,
                        accountId: String,
                        completion: @escaping (Result<ListResult?, APIError>) -> Void) {
        if let getCustomListsResult = getCustomListsResult {
            completion(getCustomListsResult)
        }
        getCustomListsCallCount += 1
    }

    var getCustomListMoviesResult: Result<MovieResult?, APIError>?
    private(set) var getCustomListMoviesCallCount = 0
    func getCustomListMovies(with accessToken: String,
                             listId: String,
                             completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getCustomListMoviesResult = getCustomListMoviesResult {
            completion(getCustomListMoviesResult)
        }
        getCustomListMoviesCallCount += 1
    }

    var getAccountDetailResult: Result<User, APIError>?
    private(set) var getAccountDetailCallCount = 0
    func getAccountDetail(with sessionId: String,
                          completion: @escaping (Result<User, APIError>) -> Void) {
        if let getAccountDetailResult = getAccountDetailResult {
            completion(getAccountDetailResult)
        }
        getAccountDetailCallCount += 1
    }

    var markAsFavoriteResult: Result<MarkAsFavoriteResult, APIError>?
    private(set) var markAsFavoriteCallCount = 0
    func markAsFavorite(_ movieId: Int,
                        sessionId: String,
                        accountId: Int,
                        favorite: Bool,
                        completion: @escaping (Result<MarkAsFavoriteResult, APIError>) -> Void) {
        if let markAsFavoriteResult = markAsFavoriteResult {
            completion(markAsFavoriteResult)
        }
        markAsFavoriteCallCount += 1
    }

    var addToWatchlistResult: Result<AddToWatchlistResult, APIError>?
    private(set) var addToWatchlistCallCount = 0
    func addToWatchlist(_ movieId: Int,
                        sessionId: String,
                        accountId: Int,
                        watchlist: Bool,
                        completion: @escaping (Result<AddToWatchlistResult, APIError>) -> Void) {
        if let addToWatchlistResult = addToWatchlistResult {
            completion(addToWatchlistResult)
        }
        addToWatchlistCallCount += 1
    }

}

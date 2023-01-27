//
//  AccountUseCaseProtocolMock.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 25/08/22.
//

public final class AccountUseCaseProtocolMock: AccountUseCaseProtocol {

    var getFavoriteListResult: Result<[Movie], Error>?
    private(set) var getFavoriteListCallCount = 0
    public func getFavoriteList(page: Int?, sortBy: MovieSortType.Favorite, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let getFavoriteListResult = getFavoriteListResult {
            completion(getFavoriteListResult)
        }
        getFavoriteListCallCount += 1
    }

    var getWatchlistResult: Result<[Movie], Error>?
    private(set) var getWatchlistCallCount = 0
    public func getWatchlist(page: Int?, sortBy: MovieSortType.Watchlist, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let getWatchlistResult = getWatchlistResult {
            completion(getWatchlistResult)
        }
        getWatchlistCallCount += 1
    }

    var getRecommendedListResult: Result<[Movie], Error>?
    private(set) var getRecommendedListCallCount = 0
    public func getRecommendedList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let getRecommendedListResult = getRecommendedListResult {
            completion(getRecommendedListResult)
        }
        getRecommendedListCallCount += 1
    }

    var getCustomListsResult: Result<[List], Error>?
    private(set) var getCustomListsCallCount = 0
    public func getCustomLists(page: Int?, completion: @escaping (Result<[List], Error>) -> Void) {
        if let getCustomListsResult = getCustomListsResult {
            completion(getCustomListsResult)
        }
        getCustomListsCallCount += 1
    }

    var getCustomListMoviesResult: Result<[Movie], Error>?
    private(set) var getCustomListMoviesCallCount = 0
    public func getCustomListMovies(listId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let getCustomListMoviesResult = getCustomListMoviesResult {
            completion(getCustomListMoviesResult)
        }
        getCustomListMoviesCallCount += 1
    }

    var getAccountDetailResult: Result<User, Error>?
    private(set) var getAccountDetailCallCount = 0
    public func getAccountDetail(completion: @escaping (Result<User, Error>) -> Void) {
        if let getAccountDetailResult = getAccountDetailResult {
            completion(getAccountDetailResult)
        }
        getAccountDetailCallCount += 1
    }

    var markMovieAsFavoriteResult: Result<Bool, Error>?
    private(set) var markMovieAsFavoriteCallCount = 0
    public func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let markMovieAsFavoriteResult = markMovieAsFavoriteResult {
            completion(markMovieAsFavoriteResult)
        }
        markMovieAsFavoriteCallCount += 1
    }

    var addToWatchlistResult: Result<Bool, Error>?
    private(set) var addToWatchlistCallCount = 0
    public func addToWatchlist(movieId: Int, watchlist: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let addToWatchlistResult = addToWatchlistResult {
            completion(addToWatchlistResult)
        }
        addToWatchlistCallCount += 1
    }

}

//
//  AccountClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class AccountClient: APIClient, AccountClientProtocol {

    let session: URLSession

    // MARK: - Initializers

    init(session: URLSession) {
        self.session = session
    }

    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        self.init(session: session)
    }

    // MARK: - Collection List

    func getFavoriteList(page: Int, sortBy: MovieSortType.Favorite, sessionId: String, accountId: Int,
                         completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = AccountProvider.getFavoriteList(page: page, sortBy: sortBy(),
                                                      sessionId: sessionId,
                                                      accountId: accountId).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    func getWatchlist(page: Int, sortBy: MovieSortType.Watchlist, sessionId: String, accountId: Int,
                      completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = AccountProvider.getWatchlist(page: page,
                                                   sortBy: sortBy(),
                                                   sessionId: sessionId,
                                                   accountId: accountId).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    // MARK: - Recommended List

    func getRecommendedList(page: Int,
                            accessToken: String,
                            accountId: String,
                            completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = AccountProvider.getRecommendedList(page: page,
                                                         accessToken: accessToken,
                                                         accountId: accountId).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    // MARK: - Custom Lists

    func getCustomLists(page: Int,
                        accessToken: String, accountId: String,
                        completion: @escaping (Result<ListResult?, APIError>) -> Void) {
        let request = AccountProvider.getCustomLists(page: page,
                                                     accessToken: accessToken,
                                                     accountId: accountId).request
        fetch(with: request, decode: { json -> ListResult? in
            guard let listResult = json as? ListResult else { return  nil }
            return listResult
        }, completion: completion)
    }

    // MARK: - Custom List Details

    func getCustomListMovies(with accessToken: String, listId: String, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = AccountProvider.getCustomListDetail(accessToken: accessToken, id: listId).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let list = json as? MovieResult else { return  nil }
            return list
        }, completion: completion)
    }

    // MARK: - Account Detail

    func getAccountDetail(with sessionId: String, completion: @escaping (Result<User, APIError>) -> Void) {
        fetch(with: AccountProvider.getAccountDetail(sessionId: sessionId).request, decode: { json -> User? in
            guard let user = json as? User else { return  nil }
            return user
        }, completion: completion)
    }

    // MARK: - Mark as favorite

    func markAsFavorite(_ movieId: Int, sessionId: String,
                        accountId: Int, favorite: Bool,
                        completion: @escaping (Result<MarkAsFavoriteResult, APIError>) -> Void) {
        fetch(with: AccountProvider.markAsFavorite(sessionId: sessionId, accountId: accountId,
                                                   movieId: movieId, favorite: favorite).request,
              decode: { json -> MarkAsFavoriteResult? in
                guard let result = json as? MarkAsFavoriteResult else { return  nil }
                return result
              }, completion: completion)
    }

    // MARK: - Add to watchlist

    func addToWatchlist(_ movieId: Int, sessionId: String,
                        accountId: Int, watchlist: Bool,
                        completion: @escaping (Result<AddToWatchlistResult, APIError>) -> Void) {
        fetch(with: AccountProvider.addToWatchlist(sessionId: sessionId, accountId: accountId,
                                                   movieId: movieId, watchlist: watchlist).request,
              decode: { json -> AddToWatchlistResult? in
                guard let result = json as? AddToWatchlistResult else { return  nil }
                return result
              }, completion: completion)
    }

}

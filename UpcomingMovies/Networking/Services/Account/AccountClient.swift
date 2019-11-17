//
//  AccountClient.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

class AccountClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // MARK: - Collection List
    
    func getCollectionList(page: Int, option: ProfileCollectionOption,
                           sessionId: String, accountId: Int,
                           completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = getCollectionListRequest(with: option, page: page,
                                               sessionId: sessionId, accountId: accountId)
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
    
    private func getCollectionListRequest(with collectionOption: ProfileCollectionOption,
                                          page: Int, sessionId: String, accountId: Int) -> URLRequest {
        switch collectionOption {
        case .favorites:
            return AccountProvider.getFavoriteList(page: page,
                                                   sessionId: sessionId,
                                                   accountId: accountId).request
        case .watchlist:
            return AccountProvider.getWatchlist(page: page,
                                                sessionId: sessionId,
                                                accountId: accountId).request
        }
    }
    
    // MARK: - Custom Lists
    
    func getCustomLists(page: Int, groupOption: ProfileGroupOption,
                        accessToken: String, accountId: String,
                        completion: @escaping (Result<ListResult?, APIError>) -> Void) {
        let request = getCustomListRequest(with: groupOption, page: page,
                                           accessToken: accessToken, accountId: accountId)
        fetch(with: request, decode: { json -> ListResult? in
            guard let listResult = json as? ListResult else { return  nil }
            return listResult
        }, completion: completion)
    }
    
    private func getCustomListRequest(with groupOption: ProfileGroupOption,
                                      page: Int,
                                      accessToken: String,
                                      accountId: String) -> URLRequest {
        switch groupOption {
        case .customLists:
            return AccountProvider.getCustomLists(page: page,
                                                  accessToken: accessToken,
                                                  accountId: accountId).request
        }
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
    
//    func markAsFavorite(_ movieId: Int, sessionId: String,
//                        accountId: Int, favorite: Bool,
//                        completion: @escaping (Result<MarkAsFavoriteResult, APIError>) -> Void) {
//        fetch(with: AccountProvider.markAsFavorite(sessionId: sessionId, accountId: accountId,
//                                                   movieId: movieId, favorite: favorite).request,
//              decode: { json -> MarkAsFavoriteResult? in
//                guard let result = json as? MarkAsFavoriteResult else { return  nil }
//                return result
//        }, completion: completion)
//    }
    
}

//
//  AccountClient.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

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
    
    func getCollectionListRequest(with collectionOption: ProfileCollectionOption,
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
    
    // MARK: - Created Lists
    
    func getCreatedLists(page: Int, sessionId: String, accountId: Int, completion: @escaping (Result<ListResult?, APIError>) -> Void) {
        let request = AccountProvider.getCreatedLists(page: page,
                                                      sessionId: sessionId,
                                                      accountId: accountId).request
        fetch(with: request, decode: { json -> ListResult? in
            guard let listResult = json as? ListResult else { return  nil }
            return listResult
        }, completion: completion)
    }
    
    func getCreatedListDetail(listId: Int, completion: @escaping (Result<List?, APIError>) -> Void) {
        let request = AccountProvider.getCreatedListDetail(id: listId).request
        fetch(with: request, decode: { json -> List? in
            guard let list = json as? List else { return  nil }
            return list
        }, completion: completion)
    }
    
    // MARK: - Account Detail
    
    func getAccountDetail(_ context: NSManagedObjectContext,
                          with sessionId: String, completion: @escaping (Result<User, APIError>) -> Void) {
        fetch(with: AccountProvider.getAccountDetail(sessionId: sessionId).request,
              context: context, decode: { json -> User? in
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
    
}

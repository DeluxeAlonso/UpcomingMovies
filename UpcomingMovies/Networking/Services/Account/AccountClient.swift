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
            fatalError("Watchlist not yet implemented")
        }
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

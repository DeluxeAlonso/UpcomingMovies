//
//  AccountProvider.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

enum AccountProvider {

    case getAccountDetail(sessionId: String)
    case getFavoriteList(page: Int, sortBy: String, sessionId: String, accountId: Int)
    case getWatchlist(page: Int, sortBy: String, sessionId: String, accountId: Int)
    case getRecommendedList(page: Int, accessToken: String, accountId: String)
    case getCustomLists(page: Int, accessToken: String, accountId: String)
    case getCustomListDetail(accessToken: String, id: String)
    case markAsFavorite(sessionId: String, accountId: Int, movieId: Int, favorite: Bool)
    case addToWatchlist(sessionId: String, accountId: Int, movieId: Int, watchlist: Bool)

}

// MARK: - Endpoint

extension AccountProvider: Endpoint {

    var base: String {
        NetworkConfiguration.shared.baseAPIURLString
    }

    var path: String {
        switch self {
        case .getAccountDetail:
            return "/3/account"
        case .getFavoriteList(_, _, _, let accountId):
            return "/3/account/\(accountId)/favorite/movies"
        case .getWatchlist(_, _, _, let accountId):
            return "/3/account/\(accountId)/watchlist/movies"
        case .getRecommendedList(_, _, let accountId):
            return "/4/account/\(accountId)/movie/recommendations"
        case .getCustomLists(_, _, let accountId):
            return "/4/account/\(accountId)/lists"
        case .getCustomListDetail(_, let id):
            return "/4/list/\(id)"
        case .markAsFavorite(_, let accountId, _, _):
            return "/3/account/\(accountId)/favorite"
        case .addToWatchlist(_, let accountId, _, _):
            return "/3/account/\(accountId)/watchlist"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getRecommendedList(_, let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        case .getCustomLists(_, let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        case .getCustomListDetail(let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        case .getAccountDetail, .getFavoriteList, .getWatchlist, .markAsFavorite, .addToWatchlist:
            return nil
        }
    }

    var params: [String: Any]? {
        switch self {
        case .getAccountDetail(let sessionId):
            return ["session_id": sessionId]
        case .getFavoriteList(let page, let sortBy, let sessionId, _):
            return ["session_id": sessionId,
                    "page": page,
                    "sort_by": sortBy]
        case .getWatchlist(let page, let sortBy, let sessionId, _):
            return ["session_id": sessionId,
                    "page": page,
                    "sort_by": sortBy]
        case .getRecommendedList(let page, _, _):
            return ["page": page]
        case .getCustomLists(let page, _, _):
            return ["page": page]
        case .getCustomListDetail:
            return nil
        case .markAsFavorite(let sessionId, _, let movieId, let favorite):
            let queryParams: [String: Any] = ["session_id": sessionId]
            let bodyParams: [String: Any] = ["media_type": "movie",
                                             "media_id": movieId,
                                             "favorite": favorite]
            return ["query": queryParams, "body": bodyParams]
        case .addToWatchlist(let sessionId, _, let movieId, let watchlist):
            let queryParams: [String: Any] = ["session_id": sessionId]
            let bodyParams: [String: Any] = ["media_type": "movie",
                                             "media_id": movieId,
                                             "watchlist": watchlist]
            return ["query": queryParams, "body": bodyParams]
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getAccountDetail, .getFavoriteList, .getWatchlist,
             .getRecommendedList, .getCustomLists, .getCustomListDetail:
            return .defaultEncoding
        case .markAsFavorite, .addToWatchlist:
            return .compositeEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAccountDetail, .getFavoriteList, .getWatchlist,
             .getRecommendedList, .getCustomLists, .getCustomListDetail:
            return .get
        case .markAsFavorite, .addToWatchlist:
            return .post
        }
    }

}

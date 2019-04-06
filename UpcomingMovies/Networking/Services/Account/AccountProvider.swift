//
//  UserProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum AccountProvider {
    
    case getFavoriteList(page: Int, sessionId: String, accountId: Int)
    case getAccountDetail(sessionId: String)
    
}

// MARK: - Endpoint

extension AccountProvider: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getFavoriteList( _, _, let accountId):
            return "/3/account/\(accountId)/favorite/movies"
        case .getAccountDetail:
            return "/3/account"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .getFavoriteList(let page, let sessionId, _):
            return ["session_id": sessionId, "page": page]
        case .getAccountDetail(let sessionId):
            return ["session_id": sessionId]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAccountDetail, .getFavoriteList:
            return .get
        }
    }
    
}

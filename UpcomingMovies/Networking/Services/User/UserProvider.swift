//
//  UserProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum UserProvider {
    
    case getAccountDetail(sessionId: String)
    
}

// MARK: - Endpoint

extension UserProvider: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getAccountDetail:
            return "/3/account"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .getAccountDetail(let sessionId):
            return ["session_id": sessionId]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAccountDetail:
            return .get
        }
    }
    
}

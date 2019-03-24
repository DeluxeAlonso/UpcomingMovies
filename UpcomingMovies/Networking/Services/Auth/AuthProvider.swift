//
//  AuthProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum AuthProvider {
    
    case getRequestToken
    case createSessionId(requestToken: String)
    
}

// MARK: - Endpoint

extension AuthProvider: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getRequestToken:
            return "/3/authentication/token/new"
        case .createSessionId:
            return "/3/authentication/session/new"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .getRequestToken:
            return nil
        case .createSessionId(let requestToken):
            return ["request_token": requestToken]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRequestToken:
            return .get
        case .createSessionId:
            return .post
        }
    }
    
}

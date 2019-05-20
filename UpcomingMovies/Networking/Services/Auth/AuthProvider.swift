//
//  AuthProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/20/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum AuthProvider {
    
    case getRequestToken(readAccessToken: String)
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
            return "/4/auth/request_token"
        case .createSessionId:
            return "/3/authentication/session/new"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getRequestToken(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
        case .createSessionId:
            return nil
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
    
    var parameterEncoding: ParameterEnconding {
        return .defaultEncoding
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRequestToken:
            return .post
        case .createSessionId:
            return .post
        }
    }
    
}

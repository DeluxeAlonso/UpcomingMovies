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
            return "/4/auth/request_token"
        case .createSessionId:
            return "/3/authentication/session/new"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getRequestToken:
            return [
                "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTQxZTZkNTQzYjE4N2YwYjdlNmJiM2ExOTAyMjA5YSIsInN1YiI6IjVjNDkwZjlhYzNhMzY4NDc3Nzg5ZjYzMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5LmQZ0jl7xA7QsREDm8FecIKq9yP0hSZ3x2MDTEn5dU"
            ]
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

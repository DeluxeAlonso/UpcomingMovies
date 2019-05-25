//
//  GenreProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

enum GenreProvider {
    
    case getAll
    
}

// MARK: - Endpoint

extension GenreProvider: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "/3/genre/movie/list"
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var params: [String: Any]? {
        switch self {
        case .getAll:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEnconding {
        return .defaultEncoding
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        }
    }
    
}

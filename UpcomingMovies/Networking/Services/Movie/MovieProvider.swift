//
//  MovieProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

enum MovieProvider {
    
    case getUpcoming(page: Int)
    case search(searchText: String)
    
}

// MARK: - Endpoint

extension MovieProvider: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .search:
            return "/3/search/movie"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .getUpcoming(let page):
            return ["page": page]
        case .search(let searchText):
            return ["query": searchText]
        }
    }
    
}

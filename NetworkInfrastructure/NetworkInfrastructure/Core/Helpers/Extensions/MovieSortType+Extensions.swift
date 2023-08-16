//
//  MovieSortType+Extensions.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 16/08/23.
//

import Foundation
import UpcomingMoviesDomain

extension MovieSortType.Watchlist {

    public func callAsFunction() -> String {
        switch self {
        case .createdAtAsc: return "created_at.asc"
        case .createdAtDesc: return "created_at.desc"
        }
    }

}

extension MovieSortType.Favorite {

    public func callAsFunction() -> String {
        switch self {
        case .createdAtAsc: return "created_at.asc"
        case .createdAtDesc: return "created_at.desc"
        }
    }

}

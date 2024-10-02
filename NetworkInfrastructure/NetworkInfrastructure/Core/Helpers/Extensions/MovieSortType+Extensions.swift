//
//  MovieSortType+Extensions.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 16/08/23.
//

import UpcomingMoviesDomain

extension MovieSortType.Watchlist {

    func callAsFunction() -> String {
        switch self {
        case .createdAtAsc: return "created_at.asc"
        case .createdAtDesc: return "created_at.desc"
        }
    }

}

extension MovieSortType.Favorite {

    func callAsFunction() -> String {
        switch self {
        case .createdAtAsc: return "created_at.asc"
        case .createdAtDesc: return "created_at.desc"
        }
    }

}

//
//  MovieSortType.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 24/08/22.
//

struct MovieSortType {

    enum Watchlist {
        case createdAtAsc
        case createdAtDesc

        func callAsFunction() -> String {
            switch self {
            case .createdAtAsc: return "created_at.asc"
            case .createdAtDesc: return "created_at.desc"
            }
        }
    }

    enum Favorites {
        case createdAtAsc
        case createdAtDesc

        func callAsFunction() -> String {
            switch self {
            case .createdAtAsc: return "created_at.asc"
            case .createdAtDesc: return "created_at.desc"
            }
        }
    }

}

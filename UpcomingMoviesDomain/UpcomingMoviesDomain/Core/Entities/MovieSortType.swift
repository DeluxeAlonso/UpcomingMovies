//
//  MovieSortType.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 24/08/22.
//

public struct MovieSortType {

    public enum Watchlist {
        case createdAtAsc
        case createdAtDesc

        public func callAsFunction() -> String {
            switch self {
            case .createdAtAsc: return "created_at.asc"
            case .createdAtDesc: return "created_at.desc"
            }
        }
    }

    public enum Favorites {
        case createdAtAsc
        case createdAtDesc

        public func callAsFunction() -> String {
            switch self {
            case .createdAtAsc: return "created_at.asc"
            case .createdAtDesc: return "created_at.desc"
            }
        }
    }

}

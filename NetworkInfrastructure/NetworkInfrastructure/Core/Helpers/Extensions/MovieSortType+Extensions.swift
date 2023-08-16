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

//public struct MovieSortType {
//
//    public enum Watchlist {
//        case createdAtAsc
//        case createdAtDesc
//
//        public func callAsFunction() -> String {
//            switch self {
//            case .createdAtAsc: return "created_at.asc"
//            case .createdAtDesc: return "created_at.desc"
//            }
//        }
//    }
//
//    public enum Favorite {
//        case createdAtAsc
//        case createdAtDesc
//
//        public func callAsFunction() -> String {
//            switch self {
//            case .createdAtAsc: return "created_at.asc"
//            case .createdAtDesc: return "created_at.desc"
//            }
//        }
//    }
//
//}

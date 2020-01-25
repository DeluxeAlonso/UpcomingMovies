//
//  MovieListFilter.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public enum MovieListFilter {
    case upcoming, popular, topRated
    case similar(movieId: Int)
    case byGenre(genreId: Int, genreName: String)
    
    public var title: String? {
        switch self {
        case .upcoming:
            return "Upcoming Movies"
        case .popular:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
        case .similar:
            return "Similar Movies"
        case .byGenre(_, let genreName):
            return genreName
        }
    }
}

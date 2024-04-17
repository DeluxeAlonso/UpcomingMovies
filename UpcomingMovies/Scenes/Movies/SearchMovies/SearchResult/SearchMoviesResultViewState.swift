//
//  SearchMoviesResultViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

enum SearchMoviesResultViewState: Equatable {

    case recentSearches
    case empty
    case searching
    case populated([MovieProtocol])
    case error(Error)

    static func == (lhs: SearchMoviesResultViewState, rhs: SearchMoviesResultViewState) -> Bool {
        switch (lhs, rhs) {
        case (.recentSearches, .recentSearches):
            return true
        case (.empty, .empty):
            return true
        case (.searching, .searching):
            return true
        case (.populated(let lhsMovies), .populated(let rhsMovies)):
            return lhsMovies.map { $0.id } == rhsMovies.map { $0.id }
        case (.error, .error):
            return true
        default:
            return false
        }
    }

    var sections: [SearchMoviesResultSections]? {
        switch self {
        case .populated:
            return [.searchedMovies]
        case .recentSearches:
            return [.recentSearches]
        case .searching, .empty, .error:
            return nil
        }
    }

    var currentSearchedMovies: [MovieProtocol] {
        switch self {
        case .populated(let entities):
            return entities
        case .recentSearches, .empty, .error, .searching:
            return []
        }
    }

}

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

    case initial
    case empty
    case searching
    case populated([Movie])
    case error(Error)

    static func == (lhs: SearchMoviesResultViewState, rhs: SearchMoviesResultViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.empty, .empty):
            return true
        case (.searching, .searching):
            return true
        case (.populated(let lhsMovies), .populated(let rhsMovies)):
            return lhsMovies == rhsMovies
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
        case .initial:
            return [.recentSearches]
        case .searching, .empty, .error:
            return nil
        }
    }

    var currentSearchedMovies: [Movie] {
        switch self {
        case .populated(let entities):
            return entities
        case .initial, .empty, .error, .searching:
            return []
        }
    }

}

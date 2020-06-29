//
//  SearchMoviesResultViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

enum SearchMoviesResultViewState {
    
    case initial
    case empty
    case searching
    case populated([Movie])
    case error(Error)
    
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
    
}

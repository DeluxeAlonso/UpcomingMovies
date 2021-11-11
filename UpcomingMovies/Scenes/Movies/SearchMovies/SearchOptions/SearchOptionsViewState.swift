//
//  SearchOptionsViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation

enum SearchOptionsViewState {

    case emptyMovieVisits
    case populatedMovieVisits

    var sections: [SearchOptionsSection] {
        switch self {
        case .emptyMovieVisits:
            return [.defaultSearches, .genres]
        case .populatedMovieVisits:
            return [.recentlyVisited, .defaultSearches, .genres]
        }
    }

}

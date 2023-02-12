//
//  UpcomingMoviesViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/12/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

enum UpcomingMoviesViewState {

    case initial
    case paging([Movie], next: Int, presentationMode: UpcomingMoviesPresentationMode)
    case populated([Movie], presentationMode: UpcomingMoviesPresentationMode)
    case empty
    case error(Error)

    static func == (lhs: UpcomingMoviesViewState, rhs: UpcomingMoviesViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (let .paging(lhsEntities, _, _), let .paging(rhsEntities, _, _)):
            return lhsEntities == rhsEntities
        case (let .populated(lhsEntities, _), let .populated(rhsEntities, _)):
            return lhsEntities == rhsEntities
        case (.empty, .empty):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }

    var currentEntities: [Movie] {
        switch self {
        case .populated(let entities, _):
            return entities
        case .paging(let entities, _, _):
            return entities
        case .initial, .empty, .error:
            return []
        }
    }

    var currentPage: Int {
        switch self {
        case .initial, .populated, .empty, .error:
            return 1
        case .paging(_, let page, _):
            return page
        }
    }

    var isInitialPage: Bool {
        currentPage == 1
    }

    var needsPrefetch: Bool {
        switch self {
        case .initial, .populated, .empty, .error:
            return false
        case .paging:
            return true
        }
    }

}

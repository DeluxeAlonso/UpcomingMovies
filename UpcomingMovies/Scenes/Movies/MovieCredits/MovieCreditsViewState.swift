//
//  MovieCreditsViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

enum MovieCreditsViewState {
    
    case initial
    case empty
    case populated([Cast], [Crew])
    case error(Error)
    
    var currentCast: [Cast] {
        switch self {
        case .populated(let cast, _):
            return cast
        case .initial, .empty, .error:
            return []
        }
    }
    
    var currentCrew: [Crew] {
        switch self {
        case .populated(_, let crew):
            return crew
        case .initial, .empty, .error:
            return []
        }
    }
    
}

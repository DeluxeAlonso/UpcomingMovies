//
//  CustomListDetailViewState.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/27/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

enum CustomListDetailViewState {

    case loading
    case empty
    case populated([Movie])
    case error(Error)

    var currentMovies: [Movie] {
        switch self {
        case .loading, .empty, .error:
            return []
        case .populated(let movies):
            return movies
        }
    }

}

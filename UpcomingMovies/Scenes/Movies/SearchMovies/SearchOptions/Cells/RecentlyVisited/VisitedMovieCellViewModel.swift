//
//  VisitedMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol VisitedMovieCellViewModelProtocol {

    var posterURL: URL? { get }

}

final class VisitedMovieCellViewModel: VisitedMovieCellViewModelProtocol {

    var posterURL: URL?

    init(movieVisit: MovieVisit) {
        let posterPath = movieVisit.posterPath
        posterURL = URL(string: posterPath)
    }

}

//
//  VisitedMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/17/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class VisitedMovieCellViewModel {
    
    var posterURL: URL?
    
    init(movieVisit: MovieVisit) {
        let posterPath = movieVisit.posterPath
        posterURL = URL(string: URLConfiguration.mediaPath + posterPath)
    }
    
}

//
//  UpcomingMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class UpcomingMovieCellViewModel {
    
    var fullPosterPath: URL?
    
    init(_ movie: Movie) {
        if let posterPath = movie.posterPath {
            fullPosterPath = URL(string: URLConfiguration.mediaPath + posterPath)
        }
    }
    
}

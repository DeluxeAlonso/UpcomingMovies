//
//  UpcomingMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class UpcomingMovieCellViewModel {
    
    var posterURL: URL?
    
    init(_ movie: Movie) {
        posterURL = movie.posterURL
    }
    
}

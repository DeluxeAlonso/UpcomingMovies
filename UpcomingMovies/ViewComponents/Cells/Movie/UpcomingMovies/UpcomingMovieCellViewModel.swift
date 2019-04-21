//
//  UpcomingMovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/24/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class UpcomingMovieCellViewModel {
    
    var title: String
    var releaseDate: String
    var posterURL: URL?
    var backdropURL: URL?
    
    init(_ movie: Movie) {
        title = movie.title
        releaseDate = movie.releaseDate
        posterURL = movie.posterURL
        backdropURL = movie.backdropURL
    }
    
}

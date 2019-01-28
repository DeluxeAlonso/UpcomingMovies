//
//  MovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class MovieCellViewModel {
    
    var name: String?
    var genre: String?
    var releaseDate: String?
    var fullPosterPath: URL?
    var voteAverage: Double?

    init(_ movie: Movie) {
        name = movie.title
        genre = movie.genreName
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        if let posterPath = movie.posterPath {
            fullPosterPath = URL(string: URLConfiguration.mediaPath + posterPath)
        }
    }
    
}

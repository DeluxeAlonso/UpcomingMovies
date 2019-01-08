//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class MovieDetailViewModel {
    
    var name: String?
    var genre: String?
    var releaseDate: String?
    var fullBackdropPath: URL?
    var overview: String?

    init(_ movie: Movie) {
        name = movie.title
        genre = movie.genreName
        releaseDate = movie.releaseDate
        overview = movie.overview
        if let backdropPath = movie.backdropPath {
            fullBackdropPath = URL(string: URLConfiguration.mediaBackdropPath + backdropPath)
        }
    }
    
}

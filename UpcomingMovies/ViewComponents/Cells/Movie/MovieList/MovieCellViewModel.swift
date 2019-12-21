//
//  MovieCellViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieCellViewModel {
    
    var name: String?
    var genreName: String? = "-"
    var releaseDate: String?
    var posterURL: URL?
    var voteAverage: Double?

    init(_ movie: Movie, genreName: String?) {
        self.name = movie.title
        self.genreName = genreName
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.posterURL = movie.posterURL
    }
    
}

//
//  MovieDetailPosterRenderContent.swift
//  UpcomingMovies
//
//  Created by Alonso on 25/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieDetailPosterRenderContentProtocol {

    var backdropURL: URL? { get }
    var posterURL: URL? { get }

}

struct MovieDetailPosterRenderContent {

    let backdropURL: URL?
    let posterURL: URL?

    init(movie: MovieProtocol) {
        self.backdropURL = movie.backdropURL
        self.posterURL = movie.posterURL
    }

}

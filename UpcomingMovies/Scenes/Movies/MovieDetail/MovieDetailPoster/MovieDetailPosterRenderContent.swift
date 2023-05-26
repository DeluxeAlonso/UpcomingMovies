//
//  MovieDetailPosterRenderContent.swift
//  UpcomingMovies
//
//  Created by Alonso on 25/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct MovieDetailPosterRenderContent {

    let backdropURL: URL?
    let posterURL: URL?

    init(movie: Movie) {
        self.backdropURL = movie.backdropURL
        self.posterURL = movie.posterURL
    }

}

//
//  MovieDetailTitleViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 24/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieDetailTitleViewModelProtocol {

    var title: String { get }
    var subtitle: String? { get }
    var voteAverage: Double? { get }

}

final class MovieDetailTitleViewModel: MovieDetailTitleViewModelProtocol {

    var title: String
    var subtitle: String?
    var voteAverage: Double?

    init(title: String = "", subtitle: String? = nil, voteAverage: Double? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.voteAverage = voteAverage
    }

    init(movie: Movie) {
        self.title = movie.title
        self.subtitle = movie.releaseDate
        self.voteAverage = movie.voteAverage
    }

}

//
//  MovieDetailTitleRenderContent.swift
//  UpcomingMovies
//
//  Created by Alonso on 25/05/23.
//  Copyright © 2023 Alonso. All rights reserved.
//

struct MovieDetailTitleRenderContent {

    let title: String
    let releaseDate: String?
    let voteAverage: Double?
    let genreIds: [Int]?

    init(movie: MovieProtocol) {
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.genreIds = movie.genreIds
    }

}

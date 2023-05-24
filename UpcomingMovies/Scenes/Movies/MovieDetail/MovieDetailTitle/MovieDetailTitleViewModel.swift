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
    var genreIds: [Int]

    init(_ renderContent: MovieDetailTitleRenderContent?) {
        self.title = renderContent?.title ?? ""
        self.subtitle = renderContent?.releaseDate
        self.voteAverage = renderContent?.voteAverage
        self.genreIds = renderContent?.genreIds ?? []
    }
}

struct MovieDetailTitleRenderContent {

    let title: String
    let releaseDate: String?
    let voteAverage: Double?
    let genreIds: [Int]

    init(movie: Movie) {
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.genreIds = movie.genreIds ?? []
    }

}

//
//  MovieProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 28/03/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieProtocol: GenreNameable {
    var id: Int { get }
    var title: String { get }
    var genreIds: [Int]? { get }
    var overview: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var posterURL: URL? { get }
    var backdropURL: URL? { get }
}

extension Movie: MovieProtocol {

    var genreId: Int? {
        genreIds?.first
    }

}

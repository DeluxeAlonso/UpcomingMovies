//
//  MovieProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 28/03/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieProtocol: GenreNameable, ImageConfigurable {
    var id: Int { get }
    var title: String { get }
    var genreIds: [Int]? { get }
    var overview: String { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var posterURL: URL? { get }
    var backdropURL: URL? { get }
}

extension Movie: MovieProtocol {

    var genreId: Int? {
        genreIds?.first
    }

    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let urlString = regularImageBaseURLString.appending(posterPath)
        return URL(string: urlString)
    }

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        let urlString = backdropImageBaseURLString.appending(backdropPath)
        return URL(string: urlString)
    }

    var genreHandler: GenreHandlerProtocol {
        DIContainer.shared.resolve()
    }

    var genreName: String {
        guard let genreId = genreId,
              let genreName = genreHandler.getGenreName(for: genreId) else {
            return "-"
        }
        return genreName
    }

}

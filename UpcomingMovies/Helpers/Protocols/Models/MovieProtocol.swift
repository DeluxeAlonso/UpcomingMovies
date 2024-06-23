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

struct MovieModel: MovieProtocol {

    let id: Int
    let title: String
    let genreIds: [Int]?
    let overview: String
    let releaseDate: String?
    let voteAverage: Double?
    let posterPath: String?
    let backdropPath: String?

    private let genreHandler: GenreHandlerProtocol

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

    var genreName: String {
        guard let genreId = genreIds?.first,
              let genreName = genreHandler.getGenreName(for: genreId) else {
            return "-"
        }
        return genreName
    }

    init(_ movie: Movie,
         genreHandler: GenreHandlerProtocol) {
        self.id = movie.id
        self.title = movie.title
        self.genreIds = movie.genreIds
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath

        self.genreHandler = genreHandler
    }

    init(_ movie: Movie) {
        self.init(movie, genreHandler: DIContainer.shared.resolve())
    }
}

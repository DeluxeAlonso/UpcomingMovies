//
//  Movie.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct Movie: Decodable {

    let id: Int
    let title: String
    let genreIds: [Int]?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    // MARK: - Initializers

    init(id: Int, title: String, genreIds: [Int]?,
         overview: String, posterPath: String?, backdropPath: String?,
         releaseDate: String, voteAverage: Double?) {
        self.id = id
        self.title = title
        self.genreIds = genreIds
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }

}

extension Movie: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.Movie {
        UpcomingMoviesDomain.Movie(id: id, title: title,
                                   genreIds: genreIds, overview: overview,
                                   posterPath: posterPath, backdropPath: backdropPath,
                                   releaseDate: releaseDate, voteAverage: voteAverage)
    }

}

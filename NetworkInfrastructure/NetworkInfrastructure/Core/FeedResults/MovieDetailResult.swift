//
//  MovieDetailResult.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/16/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

struct MovieDetailResult: Decodable {

    let id: Int
    let title: String
    let genres: [Genre]?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    func asMovie() -> Movie {
        let genreIds = genres?.compactMap { $0.id }
        return Movie(id: id, title: title,
                     genreIds: genreIds, overview: overview,
                     posterPath: posterPath, backdropPath: backdropPath,
                     releaseDate: releaseDate, voteAverage: voteAverage)
    }

}

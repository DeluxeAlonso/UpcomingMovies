//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

struct Movie: Decodable, Equatable {
    
    let id: Int
    let title: String
    let genres: [Genre]?
    let genreIds: [Int]?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double?
    
    static let posterAspectRatio: Double = 1.5
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genres
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

}

// MARK: - Computed Properties

extension Movie {
    
    var genreName: String {
        guard let genre = getGenre() else {
            return Constants.emptyGenreTitle
        }
        return genre.name
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: URLConfiguration.mediaPath + posterPath)
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: URLConfiguration.mediaBackdropPath + backdropPath)
    }
    
}

// MARK: - Private

extension Movie {
    
    private func getGenre() -> Genre? {
        // If the movie have genres assigned
        if let genres = genres, let genre = genres.first {
            return genre
        }
        // If the movie only have the genre ids assigned
        guard let genreIds = genreIds, let genre = genreIds.first else {
            return nil
        }
        return nil //PersistenceManager.shared.findGenre(with: genre)
    }
    
}

// MARK: - Constants

extension Movie {
    
    struct Constants {
        static let emptyGenreTitle = "-"
    }
    
}

// MARK: - Test mockups

extension Movie {
    
    static func with(id: Int = 1, title: String = "Movie 1",
                     genres: [Genre] = [], genreIds: [Int] = [],
                     overview: String = "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                     posterPath: String = "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                     backdropPath: String = "path2", releaseDate: String = "02-21-2019",
                     voteAverage: Double = 5.0) -> Movie {
        return Movie(id: id, title: title,
                     genres: genres, genreIds: genreIds,
                     overview: overview, posterPath: posterPath,
                     backdropPath: backdropPath, releaseDate: releaseDate,
                     voteAverage: voteAverage)
    }
    
}

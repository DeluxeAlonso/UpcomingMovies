//
//  Movie.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

public struct Movie: Equatable {
    
    public let id: Int
    public let title: String
    public let genreIds: [Int]?
    public let overview: String
    public let posterURL: URL?
    public let backdropURL: URL?
    public let releaseDate: String
    public let voteAverage: Double?
    
    // MARK: - Initializers
    
    public init(id: Int, title: String, genreIds: [Int]?,
                overview: String, posterURL: URL?, backdropURL: URL?,
                releaseDate: String, voteAverage: Double?) {
        self.id = id
        self.title = title
        self.genreIds = genreIds
        self.overview = overview
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
    
}

// MARK: - Test mockups

extension Movie {
    
    static func with(id: Int = 1,
                     title: String = "Movie 1",
                     genreIds: [Int] = [],
                     overview: String = "Overview",
                     posterURL: URL? = URL(string: "https://image.tmdb.org/t/p/w185/poster.jpg"),
                     backdropURL: URL? = URL(string: "https://image.tmdb.org/t/p/w185/backdrop.jpg"),
                     releaseDate: String = "02-21-2019", voteAverage: Double = 5.0) -> Movie {
        return Movie(id: id, title: title, genreIds: genreIds,
                     overview: overview, posterURL: posterURL,
                     backdropURL: backdropURL, releaseDate: releaseDate,
                     voteAverage: voteAverage)
    }
    
}

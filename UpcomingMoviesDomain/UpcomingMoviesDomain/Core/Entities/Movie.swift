//
//  Movie.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

public struct Movie: Equatable {

    public let id: Int
    public let title: String
    public let genreIds: [Int]?
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?

    // MARK: - Initializers

    public init(id: Int,
                title: String,
                genreIds: [Int]?,
                overview: String,
                posterPath: String?,
                backdropPath: String?,
                releaseDate: String?,
                voteAverage: Double?) {
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

// MARK: - Account state

extension Movie {

    public struct AccountState: Equatable {

        public let favorite: Bool
        public let watchlist: Bool

        public init(favorite: Bool, watchlist: Bool) {
            self.favorite = favorite
            self.watchlist = watchlist
        }

    }

}

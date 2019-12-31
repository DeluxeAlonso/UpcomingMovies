//
//  Movie.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

public struct Movie: Decodable, Equatable {
    
    public let id: Int
    public let title: String
    public let genreIds: [Int]?
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String
    public let voteAverage: Double?
    
    public static let posterAspectRatio: Double = 1.5
    
    // MARK: - Initializers
    
    public init(id: Int, title: String, genreIds: [Int]?,
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

// MARK: - Computed Properties

extension Movie {

    public var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: URLConfiguration.mediaPath + posterPath)
    }
    
    public var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: URLConfiguration.mediaBackdropPath + backdropPath)
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
    
    static func with(id: Int = 1, title: String = "Movie 1", genreIds: [Int] = [],
                     overview: String = "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                     posterPath: String = "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
                     backdropPath: String = "path2", releaseDate: String = "02-21-2019",
                     voteAverage: Double = 5.0) -> Movie {
        return Movie(id: id, title: title, genreIds: genreIds,
                     overview: overview, posterPath: posterPath,
                     backdropPath: backdropPath, releaseDate: releaseDate,
                     voteAverage: voteAverage)
    }
    
}

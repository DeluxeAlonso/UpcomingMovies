//
//  Movie.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/30/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public struct Movie: Decodable, Equatable {
    
    public let id: Int
    public let title: String
    public let genreIds: [Int]?
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String
    public let voteAverage: Double?
    
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

extension Movie: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.Movie {
        return UpcomingMoviesDomain.Movie(id: id, title: title,
                                          genreIds: genreIds, overview: overview,
                                          posterURL: posterURL, backdropURL: backdropURL,
                                          releaseDate: releaseDate, voteAverage: voteAverage)
    }
    
}

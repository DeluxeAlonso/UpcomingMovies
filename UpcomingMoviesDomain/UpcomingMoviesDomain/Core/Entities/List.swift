//
//  List.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public struct List: Equatable {

    public let id: String
    public let name: String
    public let description: String?
    public let backdropPath: String?
    public let averageRating: Double?
    public let runtime: Int?
    public let movieCount: Int
    public let movies: [Movie]?
    public let revenue: Double?

    public init(id: String,
                name: String,
                description: String?,
                backdropPath: String?,
                averageRating: Double?,
                runtime: Int?,
                movieCount: Int,
                movies: [Movie]?,
                revenue: Double?) {
        self.id = id
        self.name = name
        self.description = description
        self.backdropPath = backdropPath
        self.averageRating = averageRating
        self.runtime = runtime
        self.movieCount = movieCount
        self.movies = movies
        self.revenue = revenue
    }

}

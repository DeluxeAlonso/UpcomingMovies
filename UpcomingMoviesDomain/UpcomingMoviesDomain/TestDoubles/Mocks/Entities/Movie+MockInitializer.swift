//
//  Movie+MockInitializer.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/7/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public extension Movie {

    static func with(id: Int = 1,
                     title: String = "Movie 1",
                     genreIds: [Int] = [],
                     overview: String = "Overview",
                     posterPath: String? = "/poster.jpg",
                     backdropPath: String? = "/backdrop.jpg",
                     releaseDate: String? = "02-21-2019", voteAverage: Double = 5.0) -> Movie {
        Movie(id: id, title: title, genreIds: genreIds,
              overview: overview, posterPath: posterPath,
              backdropPath: backdropPath, releaseDate: releaseDate,
              voteAverage: voteAverage)
    }

}

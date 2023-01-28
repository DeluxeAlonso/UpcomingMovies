//
//  Movie+MockInitializer.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 9/09/22.
//

extension Movie {

    static func create(id: Int = 1,
                       title: String = "Movie 1",
                       genreIds: [Int] = [],
                       overview: String = "Overview",
                       posterPath: String? = "/poster.jpg",
                       backdropPath: String? = "/backdrop.jpg",
                       releaseDate: String = "02-21-2019", voteAverage: Double = 5.0) -> Movie {
        Movie(id: id, title: title, genreIds: genreIds,
              overview: overview, posterPath: posterPath,
              backdropPath: backdropPath, releaseDate: releaseDate,
              voteAverage: voteAverage)
    }

}

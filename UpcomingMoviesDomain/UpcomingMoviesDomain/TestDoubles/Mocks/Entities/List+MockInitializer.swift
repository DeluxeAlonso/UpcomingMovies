//
//  List+MockInitializer.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

extension List {

    static func with(id: String = "1",
                     name: String = "Test",
                     description: String = "Test",
                     backdropPath: String? = nil,
                     averageRating: Double? = nil,
                     runtime: Int? = nil,
                     movieCount: Int = 1,
                     movies: [Movie]? = [Movie.with()]) -> List {
        return List(id: id, name: name, description: description,
                    backdropPath: backdropPath, averageRating: averageRating,
                    runtime: runtime, movieCount: movieCount, movies: movies)
    }

}

//
//  MockListProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 12/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockListProtocol: ListProtocol {

    var id: String
    var name: String
    var description: String?
    var backdropURL: URL?
    var averageRating: Double?
    var runtime: Int?
    var movieCount: Int
    var movies: [MovieProtocol]
    var revenue: Double?

    init(id: String = "",
         name: String = "",
         description: String? = nil,
         backdropURL: URL? = nil,
         averageRating: Double? = nil,
         runtime: Int? = nil,
         movieCount: Int = 0,
         movies: [MovieProtocol] = [],
         revenue: Double? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.backdropURL = backdropURL
        self.averageRating = averageRating
        self.runtime = runtime
        self.movieCount = movieCount
        self.movies = movies
        self.revenue = revenue
    }

}

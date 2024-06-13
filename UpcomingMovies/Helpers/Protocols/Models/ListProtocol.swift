//
//  ListProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/06/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol ListProtocol {

    var id: String { get }
    var name: String { get }
    var description: String? { get }
    var backdropPath: String? { get }
    var averageRating: Double? { get }
    var runtime: Int? { get }
    var movieCount: Int { get }
    var movies: [MovieProtocol] { get }
    var revenue: Double? { get }

}

struct ListProtocolAdapter: ListProtocol {

    let id: String
    let name: String
    let description: String?
    let backdropPath: String?
    let averageRating: Double?
    let runtime: Int?
    let movieCount: Int
    let movies: [MovieProtocol]
    let revenue: Double?

    init(_ list: List) {
        self.id = list.id
        self.name = list.name
        self.description = list.description
        self.backdropPath = list.backdropPath
        self.averageRating = list.averageRating
        self.runtime = list.runtime
        self.movieCount = list.movieCount
        self.movies = list.movies ?? []
        self.revenue = list.revenue
    }

}

//
//  MockMovieProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 2/04/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockMovieProtocol: MovieProtocol {

    var id: Int
    var title: String
    var genreIds: [Int]?
    var overview: String
    var releaseDate: String?
    var voteAverage: Double?
    var posterURL: URL?
    var backdropURL: URL?

    var genreName: String

    init(id: Int = 0,
         title: String = "",
         genreIds: [Int]? = nil,
         overview: String = "",
         releaseDate: String? = nil,
         voteAverage: Double? = nil,
         posterURL: URL? = nil,
         backdropURL: URL? = nil,
         genreName: String = "") {
        self.id = id
        self.title = title
        self.genreIds = genreIds
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.genreName = genreName
    }

}

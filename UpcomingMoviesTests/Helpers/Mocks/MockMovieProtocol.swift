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
    var id: Int = 0
    var title: String = ""
    var genreIds: [Int]?
    var overview: String = ""
    var releaseDate: String?
    var voteAverage: Double?
    var posterURL: URL?
    var backdropURL: URL?
    var genreId: Int?
}

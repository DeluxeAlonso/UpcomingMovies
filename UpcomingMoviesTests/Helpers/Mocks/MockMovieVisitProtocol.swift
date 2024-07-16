//
//  MockMovieVisitProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 16/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockMovieVisitProtocol: MovieVisitProtocol {

    var id: Int
    var title: String
    var posterPath: String
    var createdAt: Date?

    init(id: Int = 12345,
         title: String = "",
         posterPath: String = "",
         createdAt: Date? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.createdAt = createdAt
    }

}

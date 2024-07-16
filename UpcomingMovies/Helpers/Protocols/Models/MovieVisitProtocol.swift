//
//  MovieVisitProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 15/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieVisitProtocol {

    var id: Int { get }
    var title: String { get }
    var posterPath: String { get }
    var createdAt: Date? { get }

}

struct MovieVisitModel: MovieVisitProtocol {

    let id: Int
    let title: String
    let posterPath: String
    let createdAt: Date?

    init(_ movieVisit: MovieVisit) {
        self.id = movieVisit.id
        self.title = movieVisit.title
        self.posterPath = movieVisit.posterPath
        self.createdAt = movieVisit.createdAt
    }

}

//
//  MovieCreditsProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieCreditsProtocol {

    var cast: [CastProtocol] { get }
    var crew: [CrewProtocol] { get }

}

struct MovieCreditsModel: MovieCreditsProtocol {

    let cast: [CastProtocol]
    let crew: [CrewProtocol]

    init(_ movieCredits: MovieCredits) {
        self.cast = movieCredits.cast.map(CastModel.init)
        self.crew = movieCredits.crew.map(CrewModel.init)
    }

}

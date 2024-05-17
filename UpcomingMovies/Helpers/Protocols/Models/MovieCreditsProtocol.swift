//
//  MovieCreditsProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieCreditsProtocol {

    var creditCast: [CastProtocol] { get }
    var creditCrew: [CrewProtocol] { get }
    
}

extension MovieCredits: MovieCreditsProtocol {

    var creditCast: [CastProtocol] {
        cast
    }

    var creditCrew: [CrewProtocol] {
        crew
    }

}

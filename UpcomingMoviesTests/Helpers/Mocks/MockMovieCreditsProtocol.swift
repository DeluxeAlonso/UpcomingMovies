//
//  MockMovieCreditsProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 18/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

@testable import UpcomingMovies

final class MockMovieCreditsProtocol: MovieCreditsProtocol {

    var cast: [CastProtocol]
    var crew: [CrewProtocol]

    init(creditCast: [CastProtocol] = [],
         creditCrew: [CrewProtocol] = []) {
        self.cast = creditCast
        self.crew = creditCrew
    }

}

//
//  MockMovieCreditsProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 18/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockMovieCreditsProtocol: MovieCreditsProtocol {

    var creditCast: [CastProtocol]
    var creditCrew: [CrewProtocol]

    init(creditCast: [CastProtocol] = [],
         creditCrew: [CrewProtocol] = []) {
        self.creditCast = creditCast
        self.creditCrew = creditCrew
    }

}

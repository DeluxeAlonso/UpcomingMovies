//
//  MockCrewProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 13/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockCrewProtocol: CrewProtocol {

    var id: Int
    var job: String
    var name: String
    var profileURL: URL?

    init(id: Int = 0,
         job: String = "",
         name: String = "",
         profileURL: URL? = nil) {
        self.id = id
        self.job = job
        self.name = name
        self.profileURL = profileURL
    }

}

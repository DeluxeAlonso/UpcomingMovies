//
//  MockCastProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 13/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockCastProtocol: CastProtocol {

    var id: Int
    var character: String
    var name: String
    var profileURL: URL?

    init(id: Int = 0,
         character: String = "",
         name: String = "",
         profileURL: URL? = nil) {
        self.id = id
        self.character = character
        self.name = name
        self.profileURL = profileURL
    }

}

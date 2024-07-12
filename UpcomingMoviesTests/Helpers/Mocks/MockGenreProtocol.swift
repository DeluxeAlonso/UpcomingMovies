//
//  MockGenreProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 12/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockGenreProtocol: GenreProtocol {

    var id: Int
    var name: String

    init(id: Int = 12345,
         name: String = "") {
        self.id = id
        self.name = name
    }

}

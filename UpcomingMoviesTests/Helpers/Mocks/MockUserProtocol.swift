//
//  MockUserProtocol.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 21/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies

final class MockUserProtocol: UserProtocol {

    var id: Int
    var name: String
    var username: String
    var includeAdult: Bool
    var avatarPath: String?

    init(id: Int = 12345,
         name: String = "",
         username: String = "",
         includeAdult: Bool = false,
         avatarPath: String? = nil) {
        self.id = id
        self.name = name
        self.username = username
        self.includeAdult = includeAdult
        self.avatarPath = avatarPath
    }

}

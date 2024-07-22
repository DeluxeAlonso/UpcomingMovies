//
//  UserProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 21/07/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

protocol UserProtocol {

    var id: Int { get }
    var name: String { get }
    var username: String { get }
    var includeAdult: Bool { get }
    var avatarPath: String? { get }

}

struct UserModel: UserProtocol {

    let id: Int
    let name: String
    let username: String
    let includeAdult: Bool
    let avatarPath: String?

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

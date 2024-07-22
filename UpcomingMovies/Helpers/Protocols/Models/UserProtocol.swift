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

    init(_ user: User) {
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.includeAdult = user.includeAdult
        self.avatarPath = user.avatarPath
    }

}

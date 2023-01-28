//
//  User.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct User: Decodable {

    let id: Int
    let name: String
    let username: String
    let includeAdult: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case includeAdult = "include_adult"
    }

}

extension User: DomainConvertible {

    func asDomain() -> UpcomingMoviesDomain.User {
         UpcomingMoviesDomain.User(id: id, name: name,
                                         username: username, includeAdult: includeAdult)
    }

}

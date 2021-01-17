//
//  User.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 1/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public struct User: Decodable {
    
    public let id: Int
    public let name: String
    public let username: String
    public let includeAdult: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case includeAdult = "include_adult"
    }
    
}

extension User: DomainConvertible {
    
    func asDomain() -> UpcomingMoviesDomain.User {
        return UpcomingMoviesDomain.User(id: id, name: name,
                                         username: username, includeAdult: includeAdult)
    }
    
}

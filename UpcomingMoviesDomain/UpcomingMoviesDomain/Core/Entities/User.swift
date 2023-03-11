//
//  User.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public struct User: Equatable {

    public let id: Int
    public let name: String
    public let username: String
    public let includeAdult: Bool
    public let avatarPath: String?

    public init(id: Int, name: String, username: String, includeAdult: Bool, avatarPath: String?) {
        self.id = id
        self.name = name
        self.username = username
        self.includeAdult = includeAdult
        self.avatarPath = avatarPath
    }

}

//
//  User+MockInitializer.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

public extension User {

    static func with(id: Int = 1,
                     name: String = "Test",
                     username: String = "Username",
                     includeAdult: Bool = false,
                     avatarPath: String? = nil) -> User {
        User(id: id, name: name, username: username, includeAdult: includeAdult, avatarPath: avatarPath)
    }

}

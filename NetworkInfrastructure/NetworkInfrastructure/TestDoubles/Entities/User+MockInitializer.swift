//
//  User+MockInitializer.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/09/22.
//

extension User {

    static func create(id: Int = 1,
                       name: String = "Test",
                       username: String = "Username",
                       includeAdult: Bool = false,
                       avatar: Avatar? = nil) -> User {
        User(id: id, name: name, username: username, includeAdult: includeAdult, avatar: avatar)
    }

}

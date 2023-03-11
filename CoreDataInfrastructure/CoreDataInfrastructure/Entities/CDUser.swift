//
//  CDUser.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData
import UpcomingMoviesDomain

// swiftlint:disable function_parameter_count
final class CDUser: NSManagedObject {

    @NSManaged private(set) var id: Int
    @NSManaged private(set) var name: String
    @NSManaged private(set) var username: String
    @NSManaged private(set) var includeAdult: Bool
    @NSManaged private(set) var avatarPath: String?

    static func insert(into context: NSManagedObjectContext,
                       id: Int,
                       name: String,
                       username: String,
                       includeAdult: Bool,
                       avatarPath: String?) -> CDUser {
        let user: CDUser = context.insertObject()
        user.id = id
        user.name = name
        user.username = username
        user.includeAdult = includeAdult
        user.avatarPath = avatarPath
        return user
    }

}

// MARK: - DomainConvertible

extension CDUser: DomainConvertible {

    func asDomain() -> User {
        User(id: id, name: name, username: username, includeAdult: includeAdult, avatarPath: avatarPath)
    }

}

// MARK: - Managed

extension CDUser: Managed { }

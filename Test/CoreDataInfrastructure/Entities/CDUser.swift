//
//  CDUser.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData
import UpcomingMoviesDomain

final class CDUser: NSManagedObject {
    
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var username: String
    @NSManaged fileprivate(set) var includeAdult: Bool
    
    static func insert(into context: NSManagedObjectContext,
                       id: Int,
                       name: String,
                       username: String,
                       includeAdult: Bool) -> CDUser {
        let user: CDUser = context.insertObject()
        user.id = id
        user.name = name
        user.username = username
        user.includeAdult = includeAdult
        return user
    }
    
}

// MARK: - DomainConvertible

extension CDUser: DomainConvertible {
    
    func asDomain() -> User {
        return User(id: id, name: name, username: username, includeAdult: includeAdult)
    }
    
}

// MARK: - Managed

extension CDUser: Managed { }

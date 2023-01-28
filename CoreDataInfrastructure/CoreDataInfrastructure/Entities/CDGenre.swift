//
//  CDGenre.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData
import UpcomingMoviesDomain

final class CDGenre: NSManagedObject {

    @NSManaged private(set) var id: Int
    @NSManaged private(set) var name: String

    static func insert(into context: NSManagedObjectContext, id: Int, name: String) -> CDGenre {
        let genre: CDGenre = context.insertObject()
        genre.id = id
        genre.name = name
        return genre
    }

}

// MARK: - DomainConvertible

extension CDGenre: DomainConvertible {

    func asDomain() -> Genre {
        Genre(id: id, name: name)
    }

}

// MARK: - Managed

extension CDGenre: Managed {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        [NSSortDescriptor(key: #keyPath(name), ascending: true)]
    }

}

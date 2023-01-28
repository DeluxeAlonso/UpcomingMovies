//
//  CDMovieVisit.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData
import UpcomingMoviesDomain

final class CDMovieVisit: NSManagedObject {

    @NSManaged private(set) var id: Int
    @NSManaged private(set) var title: String
    @NSManaged private(set) var posterPath: String
    @NSManaged private(set) var createdAt: Date

    static func insert(into context: NSManagedObjectContext, id: Int, title: String, posterPath: String) -> CDMovieVisit {
        let movieVisit: CDMovieVisit = context.insertObject()
        movieVisit.id = id
        movieVisit.title = title
        movieVisit.posterPath = posterPath
        movieVisit.createdAt = Date()
        return movieVisit
    }

}

// MARK: - DomainConvertible

extension CDMovieVisit: DomainConvertible {

    func asDomain() -> MovieVisit {
        MovieVisit(id: id,
                   title: title,
                   posterPath: posterPath,
                   createdAt: createdAt)
    }

}

// MARK: - Managed

extension CDMovieVisit: Managed {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }

}

//
//  CDMovieVisit.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData
import UpcomingMoviesDomain

final class CDMovieVisit: NSManagedObject {
    
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var title: String
    @NSManaged fileprivate(set) var posterPath: String
    @NSManaged fileprivate(set) var createdAt: Date
    
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
        return MovieVisit(id: id,
                          title: title,
                          posterPath: posterPath,
                          createdAt: createdAt)
    }
    
}

// MARK: - Managed

extension CDMovieVisit: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
    
}

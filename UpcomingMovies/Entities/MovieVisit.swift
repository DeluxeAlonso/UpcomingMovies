//
//  MovieVisit.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class MovieVisit: NSManagedObject {
    
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var title: String
    @NSManaged fileprivate(set) var posterPath: String
    @NSManaged fileprivate(set) var createdAt: Date
    
    static func insert(into context: NSManagedObjectContext, id: Int, title: String, posterPath: String) -> MovieVisit {
        let movieVisit: MovieVisit = context.insertObject()
        movieVisit.id = id
        movieVisit.title = title
        movieVisit.posterPath = posterPath
        movieVisit.createdAt = Date()
        return movieVisit
    }
    
}

extension MovieVisit: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
    
}

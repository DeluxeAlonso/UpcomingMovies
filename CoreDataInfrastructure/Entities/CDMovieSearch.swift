//
//  CDMovieSearch.swift
//  CoreDataInfrastructure
//
//  Created by Alonso on 10/27/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import CoreData
import UpcomingMoviesDomain

final class CDMovieSearch: NSManagedObject {
    
    @NSManaged fileprivate(set) var searchText: String
    @NSManaged fileprivate(set) var createdAt: Date
    
    static func insert(into context: NSManagedObjectContext, searchText: String) -> CDMovieSearch {
        let movieSearch: CDMovieSearch = context.insertObject()
        movieSearch.searchText = searchText
        movieSearch.createdAt = Date()
        return movieSearch
    }
    
}

extension CDMovieSearch: DomainConvertible {
    
    func asDomain() -> MovieSearch {
        return MovieSearch(searchText: searchText, createdAt: createdAt)
    }
    
}

extension CDMovieSearch: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
    
}

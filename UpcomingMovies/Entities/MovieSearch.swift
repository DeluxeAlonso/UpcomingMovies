//
//  MovieSearch.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class MovieSearch: NSManagedObject {
    
    @NSManaged fileprivate(set) var searchText: String
    @NSManaged fileprivate(set) var createdAt: Date
    
    static func insert(into context: NSManagedObjectContext, searchText: String) -> MovieSearch {
        let movieSearch: MovieSearch = context.insertObject()
        movieSearch.searchText = searchText
        movieSearch.createdAt = Date()
        return movieSearch
    }
    
}

extension MovieSearch: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
    
}

//
//  Favorite.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class Favorite: NSManagedObject {
    
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var title: String
    @NSManaged fileprivate(set) var backdropPath: String?
    @NSManaged fileprivate(set) var createdAt: Date
    
    static func insert(into context: NSManagedObjectContext, id: Int, title: String, backdropPath: String) -> Favorite {
        let favorite: Favorite = context.insertObject()
        favorite.id = id
        favorite.title = title
        favorite.backdropPath = backdropPath
        favorite.createdAt = Date()
        return favorite
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: URLConfiguration.mediaBackdropPath + backdropPath)
    }
    
}

extension Favorite: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
    
}

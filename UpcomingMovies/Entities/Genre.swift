//
//  Genre.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class Genre: NSManagedObject {
    
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var name: String
    
    static func insert(into context: NSManagedObjectContext, id: Int, name: String) -> Genre {
        let genre: Genre = context.insertObject()
        genre.id = id
        genre.name = name
        return genre
    }
    
}

// MARK: - Decodable

extension Genre: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    // MARK: - Initializer
    
    convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Missing context or invalid context")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: Genre.entityName, in: context) else {
            fatalError("Unknown entity in context")
        }
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    // MARK: -
    
    static func find(by id: Int, in context: NSManagedObjectContext) -> Genre? {
        let predicate = NSPredicate(format: "id == %d", id)
        guard let genre = findOrFetch(in: context, matching: predicate) else {
            return nil
        }
        return genre
    }
    
    static func findAll(in context: NSManagedObjectContext) -> [Genre] {
        return fetch(in: context)
    }
    
}

// MARK: - Managed

extension Genre: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(name), ascending: true)]
    }
    
}

// MARK: - Test mockups

extension Genre {
    
    static func with(id: Int = 1,
                     name: String = "Genre 1",
                     context: NSManagedObjectContext) -> Genre {
        return Genre.insert(into: context, id: id, name: name)
    }
    
}

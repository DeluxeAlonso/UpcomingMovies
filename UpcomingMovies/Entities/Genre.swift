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
    
}

// MARK: - Decodable

extension Genre: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
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

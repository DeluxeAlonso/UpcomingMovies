//
//  User.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/31/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class User: NSManagedObject {
    
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var username: String
    @NSManaged fileprivate(set) var includeAdult: Bool
    
}

// MARK: - Decodable

extension User: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case includeAdult = "include_adult"
    }
    
    // MARK: - Initializer
    
    convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Missing context or invalid context")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: User.entityName, in: context) else {
            fatalError("Unknown entity in context")
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.includeAdult = try container.decode(Bool.self, forKey: .includeAdult)
    }
    
}

// MARK: - Managed

extension User: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(name), ascending: true)]
    }
    
}

//
//  PersistenceManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static let shared = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UpcomingMovies")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError() }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Movie Genres
    
    var genres: [Genre] = []
    
    func findGenre(with id: Int) -> Genre? {
        return genres.filter { $0.id == id }.first
    }
    
}

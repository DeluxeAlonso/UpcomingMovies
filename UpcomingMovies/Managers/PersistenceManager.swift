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
    
    private var genreStore: PersistenceStore<Genre>!
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UpcomingMovies")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError() }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        let container = isTesting() ? mockPersistantContainer : persistentContainer
        let context = container.viewContext
        context.mergePolicy = NSMergePolicy.overwrite
        return context
    }
    
    // MARK: - Initializers
    
    init() {
        setupStores()
    }
    
    // MARK: - Private
    
    private func setupStores() {
        genreStore = PersistenceStore(mainContext)
    }
    
    // MARK: - Movie Genres
    
    var genres: [Genre] {
        return genreStore.findAll()
    }
    
    func findGenre(with id: Int) -> Genre? {
        return genres.filter { $0.id == id }.first
    }
    
    // MARK: - Test mockups
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UpcomingMovies")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()
    
    private func isTesting() -> Bool {
        return NSClassFromString("XCTest") != nil
    }
    
}

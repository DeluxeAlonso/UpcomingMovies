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
        let context = persistentContainer.viewContext
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
    
}

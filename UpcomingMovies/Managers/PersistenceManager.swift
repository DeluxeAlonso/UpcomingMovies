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
    
    // MARK: - Movie Genres
    
    var genres: [Genre] {
        return Genre.findAll(in: persistentContainer.viewContext)
    }
    
    func findGenre(with id: Int) -> Genre? {
        return Genre.find(by: id, in: persistentContainer.viewContext)
    }
    
    // MARK: - Visited Movies
    
    func saveVisitedMovie(with id: Int, title: String, posterPath: String?) {
        guard let posterPath = posterPath else { return }
        let managedObjectContext = persistentContainer.viewContext
        managedObjectContext.performChanges {
            _ = MovieVisit.insert(into: managedObjectContext,
                                  id: id,
                                  title: title,
                                  posterPath: posterPath)
        }
    }
    
    // MARK: - Favorite Movies
    
    func isFavorite(for movieId: Int) -> Bool {
        return Favorite.find(by: movieId, in: persistentContainer.viewContext) != nil
    }
    
    func saveFavorite(with id: Int, title: String, backdropPath: String?) {
        let managedObjectContext = persistentContainer.viewContext
        managedObjectContext.performChanges {
            _ = Favorite.insert(into: managedObjectContext,
                                id: id,
                                title: title,
                                backdropPath: backdropPath)
        }
    }
    
    func removeFavorite(with id: Int) {
        let managedObjectContext = persistentContainer.viewContext
        guard let favorite = Favorite.find(by: id, in: managedObjectContext) else {
            return
        }
        favorite.managedObjectContext?.performChanges {
            favorite.managedObjectContext?.delete(favorite)
        }
    }
    
}

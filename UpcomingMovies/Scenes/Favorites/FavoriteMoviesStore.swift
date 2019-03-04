//
//  FavoriteMoviesStore.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

protocol FavoriteMoviesStoreDelegate: class {
    
    func favoriteMoviesStore(_ favoriteMoviesStore: FavoriteMoviesStore, didUpdateFavorites update: Bool)
    
}

class FavoriteMoviesStore: NSObject {
    
    private var managedObjectContext: NSManagedObjectContext
    private var fetchedResultsController: NSFetchedResultsController<Favorite>
    
    weak var delegate: FavoriteMoviesStoreDelegate?
    
    var favoriteMovies: [Favorite] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        let request = Favorite.sortedFetchRequest
        request.fetchBatchSize = 5
        request.returnsObjectsAsFaults = false
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
    }
    
    func loadFavoriteMovies() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension FavoriteMoviesStore: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        delegate?.favoriteMoviesStore(self, didUpdateFavorites: true)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}

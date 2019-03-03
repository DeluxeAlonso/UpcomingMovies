//
//  FavoriteMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class FavoriteMoviesViewModel: NSObject {
    
    private var managedObjectContext: NSManagedObjectContext!
    private var fetchedResultsController: NSFetchedResultsController<Favorite>
    
    var updateFavorites: (() -> Void)?
    
    var favoriteMovieCells: [FavoriteMovieCellViewModel] {
        guard let favorites = fetchedResultsController.fetchedObjects else {
            return []
        }
        return favorites.map { FavoriteMovieCellViewModel($0) }
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
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
        loadFavoriteMovies()
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

extension FavoriteMoviesViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        updateFavorites?()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}

//
//  SearchMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchMoviesViewModel: NSObject {
    
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<MovieSearch>
    
    var recentSearches: [MovieSearch] {
        guard let searches = fetchedResultsController.fetchedObjects else {
            return []
        }
        return searches
    }
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        let request = MovieSearch.sortedFetchRequest
        request.fetchBatchSize = 5
        request.fetchLimit = 5
        request.returnsObjectsAsFaults = false
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        loadRecentSearches()
    }
    
    func loadRecentSearches() {
        try! fetchedResultsController.performFetch()
    }
    
    func saveSearchText(_ searchText: String) {
        managedObjectContext.performChanges {
            _ = MovieSearch.insert(into: self.managedObjectContext, searchText: searchText)
        }
    }

}

// MARK: - NSFetchedResultsControllerDelegate

extension SearchMoviesViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}

//
//  SearchMoviesStore.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

protocol SearchMoviesResultStoreDelegate: class {
    
    func searchMoviesResultStore(_ searchMoviesResultStore: SearchMoviesResultStore, willUpdateSearchMovies shouldPrepare: Bool)
    func searchMoviesResultStore(_ searchMoviesResultStore: SearchMoviesResultStore, didUpdateSearchMovies update: Bool)
    
}

class SearchMoviesResultStore: NSObject {
    
    private var managedObjectContext: NSManagedObjectContext!
    private var fetchedResultsController: NSFetchedResultsController<MovieSearch>
    
    weak var delegate: SearchMoviesResultStoreDelegate?
    
    var recentSearches: [MovieSearch] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    init(_ managedObjectContext: NSManagedObjectContext) {
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
    }
    
    func loadRecentSearches() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveSearchText(_ searchText: String) {
        managedObjectContext.performChanges {
            _ = MovieSearch.insert(into: self.managedObjectContext, searchText: searchText)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension SearchMoviesResultStore: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.searchMoviesResultStore(self, willUpdateSearchMovies: true)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        delegate?.searchMoviesResultStore(self, didUpdateSearchMovies: true)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.searchMoviesResultStore(self, willUpdateSearchMovies: false)
    }
    
}

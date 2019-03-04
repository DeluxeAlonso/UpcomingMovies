//
//  SearchOptionsStore.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

protocol SearchOptionsStoreDelegate: class {
    
    func searchOptionsStore(_ searchOptionsStore: SearchOptionsStore, willUpdateVisitedMovies shouldPrepare: Bool)
    func searchOptionsStore(_ searchOptionsStore: SearchOptionsStore, didUpdateVisitedMovies update: Bool)
    
}

class SearchOptionsStore: NSObject {
    
    private var managedObjectContext: NSManagedObjectContext!
    private var fetchedResultsController: NSFetchedResultsController<MovieVisit>
    
    weak var delegate: SearchOptionsStoreDelegate?
    
    var visitedMovies: [MovieVisit] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    var genres: [Genre] {
        return PersistenceManager.shared.genres
    }
    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        let request = MovieVisit.sortedFetchRequest
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
    
    func loadMovieVisits() {
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

extension SearchOptionsStore: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.searchOptionsStore(self, willUpdateVisitedMovies: true)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        delegate?.searchOptionsStore(self, didUpdateVisitedMovies: true)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.searchOptionsStore(self, willUpdateVisitedMovies: false)
    }
    
}

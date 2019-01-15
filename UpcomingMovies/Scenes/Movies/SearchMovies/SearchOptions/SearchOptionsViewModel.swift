//
//  SearchOptionsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchOptionsViewModel: NSObject {
    
    private var managedObjectContext: NSManagedObjectContext!
    private var fetchedResultsController: NSFetchedResultsController<MovieVisit>
    
    let viewState: Bindable<SearchOptionsViewState> = Bindable(.initial)
    
    var visitedMovies: [MovieVisit] {
        guard let visited = fetchedResultsController.fetchedObjects else {
            return []
        }
        return visited
    }
    
    var genres: [Genre] {
        return AppManager.shared.genres
    }
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        let request = MovieVisit.sortedFetchRequest
        request.fetchBatchSize = 10
        request.fetchLimit = 10
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: managedObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
        loadMovieVisits()
    }
    
    // MARK: - Movie visits persistence
    
    func loadMovieVisits() {
        try! fetchedResultsController.performFetch()
    }
    
}

// MARK: - View states

extension SearchOptionsViewModel {
    
    enum SearchOptionsViewState {
        case initial
        
        var sections: [SearchOptionsSections] {
            switch self {
            case .initial:
                return [.recentlyVisited, .defaultSearches, .genres]
            }
        }
        
    }
    
    enum SearchOptionsSections {
        case recentlyVisited, defaultSearches, genres
        
        var title: String? {
            switch self {
            case .recentlyVisited:
                return "Recently visited"
            case .defaultSearches:
                return nil
            case .genres:
                return "Movie genres"
            }
        }
        
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension SearchOptionsViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}

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
    var prepareUpdate: ((Bool) -> Void)?
    var updateVisitedMovies: (() -> Void)?
    var selectedDefaultSearchOption: ((DefaultSearchOption) -> Void)?
    var selectedMovieGenre: ((Int) -> Void)?
    
    var visitedMovieCells: [VisitedMovieCellViewModel] {
        guard let visited = fetchedResultsController.fetchedObjects else {
            return []
        }
        return visited.map { VisitedMovieCellViewModel(movieVisit: $0) }
    }
    
    var genreCells: [GenreSearchOptionCellViewModel] {
        let genres = Genre.findAll(in: managedObjectContext)
        return genres.map { GenreSearchOptionCellViewModel(genre: $0) }
    }
    
    let defaultSearchOptions: [DefaultSearchOption] = [.popular, .topRated]
    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModel] {
        return defaultSearchOptions.map { DefaultSearchOptionCellViewModel(defaultSearchOption: $0) }
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
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Public
    
    func prepareRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModel {
        return RecentlyVisitedMoviesCellViewModel(visitedMovieCells: visitedMovieCells)
    }
    
    func getDefaultSearchSelection(by index: Int) {
        let defaultSearchOption = defaultSearchOptions[index]
        selectedDefaultSearchOption?(defaultSearchOption)
    }
    
    func getMovieGenreSelection(by index: Int) {
        let genres = Genre.findAll(in: managedObjectContext)
        let selectedGenre = genres[index]
        selectedMovieGenre?(selectedGenre.id)
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
    
    func section(at index: Int) -> SearchOptionsSections {
        return viewState.value.sections[index]
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension SearchOptionsViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        prepareUpdate?(true)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        updateVisitedMovies?()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        prepareUpdate?(false)
    }
    
}

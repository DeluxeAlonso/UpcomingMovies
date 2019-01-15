
//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchMoviesResultViewModel: NSObject {
    
    // MARK: - Properties
    
    private let movieClient = MovieClient()
    private var movies: [Movie] = []
    
    private var managedObjectContext: NSManagedObjectContext!
    private var fetchedResultsController: NSFetchedResultsController<MovieSearch>
    
    let viewState: Bindable<SearchMoviesResultViewState> = Bindable(.initial)
    
    // MARK: - Computed Properties
    
    var recentSearches: [MovieSearch] {
        guard let searches = fetchedResultsController.fetchedObjects else {
            return []
        }
        return searches
    }
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initilalizers
    
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
    
    // MARK: - Movies handling
    
    private func processMovieResult(_ movieResult: MovieResult) {
        guard let fetchedMovies = movieResult.results else {
            return
        }
        movies = fetchedMovies
        if movies.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(movies)
        }
    }
    
    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
        saveSearchText(searchText)
        movieClient.searchMovies(searchText: searchText) { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self.processMovieResult(movieResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    func clearMovies() {
        movies = []
    }
    
    // MARK: - Recent searches persistence
    
    func loadRecentSearches() {
        try! fetchedResultsController.performFetch()
    }
    
    func saveSearchText(_ searchText: String) {
        managedObjectContext.performChanges {
            _ = MovieSearch.insert(into: self.managedObjectContext, searchText: searchText)
        }
    }
    
    // MARK: - Movie detail builder
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index])
    }

}

// MARK: - View states

extension SearchMoviesResultViewModel {
    
    enum SearchMoviesResultViewState {
        
        case initial
        case empty
        case searching
        case populated([Movie])
        case error(Error)
        
        var sections: [SearchMoviesResultSections]? {
            switch self {
            case .populated:
                return [.searchedMovies]
            case .initial:
                return [.recentSearches]
            case .searching, .empty, .error:
                return nil
            }
        }
        
    }
    
    enum SearchMoviesResultSections {
        case recentSearches, searchedMovies
    }
    
    func resetViewState() {
        clearMovies()
        viewState.value = .initial
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension SearchMoviesResultViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}

//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchMoviesResultViewModel {
    
    // MARK: - Properties
    private var managedObjectContext: NSManagedObjectContext
    
    private var movieSearchStore: PersistenceStore<MovieSearch>!
    
    private let movieClient = MovieClient()
    private var movies: [Movie] = []
    
    let viewState: Bindable<ViewState> = Bindable(.initial)

    var updateRecentSearches: (() -> Void)?
    
    // MARK: - Computed Properties
    
    var recentSearchCells: [RecentSearchCellViewModel] {
        let searches = movieSearchStore.entities
        return searches.map { RecentSearchCellViewModel(searchText: $0.searchText) }
    }
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initilalizers
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        movieSearchStore = PersistenceStore(managedObjectContext)
        movieSearchStore.configureResultsContoller(limit: 5, sortDescriptors: MovieSearch.defaultSortDescriptors)
        movieSearchStore.delegate = self
    }
    
    // MARK: - Movies handling
    
    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
        movieSearchStore.saveMovieSearch(with: searchText)
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
    
    private func processMovieResult(_ movieResult: MovieResult) {
        let fetchedMovies = movieResult.results
        movies = fetchedMovies
        if movies.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(movies)
        }
    }
    
    func clearMovies() {
        movies = []
    }
    
    // MARK: - Movie detail builder
    
    func buildDetailViewModel(at index: Int) -> MovieDetailViewModel {
        return MovieDetailViewModel(movies[index])
    }

}

// MARK: - SearchMoviesResultStore

extension SearchMoviesResultViewModel: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {
    }
    
    func persistenceStore(didUpdateEntity update: Bool) {
        updateRecentSearches?()
    }

}

// MARK: - View states

extension SearchMoviesResultViewModel {
    
    enum ViewState {
        
        case initial
        case empty
        case searching
        case populated([Movie])
        case error(ErrorDescriptable)
        
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

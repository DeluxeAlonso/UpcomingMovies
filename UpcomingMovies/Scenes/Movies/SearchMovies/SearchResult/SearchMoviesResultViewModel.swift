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
    
    private var movieSearchStore: PersistenceStore<MovieSearch>!
    
    private let movieClient = MovieClient()
    private var movies: [Movie] = []
    
    let viewState: Bindable<SearchMoviesResultViewState> = Bindable(.initial)
    
    var prepareUpdate: ((Bool) -> Void)?
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
        movieSearchStore = PersistenceStore(managedObjectContext)
        movieSearchStore.configure(limit: 5)
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
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index],
                                    managedObjectContext: movieSearchStore.managedObjectContext)
    }

}

// MARK: - SearchMoviesResultStore

extension SearchMoviesResultViewModel: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {
        prepareUpdate?(shouldPrepare)
    }
    
    func persistenceStore(didUpdateEntity update: Bool) {
        updateRecentSearches?()
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

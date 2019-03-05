//
//  SearchOptionsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import CoreData

final class SearchOptionsViewModel {
    
    private var movieVisitStore: PersistenceStore<MovieVisit>!
    
    let viewState: Bindable<SearchOptionsViewState> = Bindable(.initial)
    
    var prepareUpdate: ((Bool) -> Void)?
    var updateVisitedMovies: (() -> Void)?
    
    var selectedDefaultSearchOption: ((DefaultSearchOption) -> Void)?
    var selectedMovieGenre: ((Int) -> Void)?
    
    var visitedMovieCells: [VisitedMovieCellViewModel] {
        let visited = movieVisitStore.entities
        return visited.map { VisitedMovieCellViewModel(movieVisit: $0) }
    }
    
    var genreCells: [GenreSearchOptionCellViewModel] {
        let genres = PersistenceManager.shared.genres
        return genres.map { GenreSearchOptionCellViewModel(genre: $0) }
    }
    
    let defaultSearchOptions: [DefaultSearchOption] = [.popular, .topRated]
    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModel] {
        return defaultSearchOptions.map { DefaultSearchOptionCellViewModel(defaultSearchOption: $0) }
    }
    
    // MARK: - Initializers
    
    init(managedObjectContext: NSManagedObjectContext) {
        movieVisitStore = PersistenceStore(managedObjectContext)
        movieVisitStore.configure(limit: 10)
        movieVisitStore.delegate = self
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
        let genres = PersistenceManager.shared.genres
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

// MARK: - SearchOptionsStoreDelegate

extension SearchOptionsViewModel: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {
        prepareUpdate?(shouldPrepare)
    }
    
    func persistenceStore(didUpdateEntity update: Bool) {
        updateVisitedMovies?()
    }
    
}

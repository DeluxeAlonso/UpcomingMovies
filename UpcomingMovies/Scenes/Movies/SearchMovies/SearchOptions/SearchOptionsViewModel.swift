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
    
    let viewState: Bindable<SearchOptionsViewState> = Bindable(.emptyMovieVisits)
    
    var needsContentReload: (() -> Void)?
    var updateVisitedMovies: ((Int?) -> Void)?
    
    var selectedDefaultSearchOption: ((DefaultSearchOption) -> Void)?
    var selectedMovieGenre: ((Int) -> Void)?
    var selectedRecentlyVisitedMovie: ((Int, String) -> Void)?
    
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
        
        configureViewState()
    }
    
    // MARK: - Private
    
    /**
     * Configures the state of the view according to the saved movie visists
     * quantity. Returns true if the state changed and false if not.
     */
    @discardableResult
    private func configureViewState() -> Bool {
        let oldViewState = viewState.value
        if movieVisitStore.exists() {
            viewState.value = .populatedMovieVisits
        } else {
            viewState.value = .emptyMovieVisits
        }
        return oldViewState != viewState.value
    }
    
    // MARK: - Public
    
    func sectionIndex(for section: SearchOptionsSection) -> Int? {
        let sections = viewState.value.sections
        return sections.firstIndex(of: section)
    }
    
    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModel {
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
    
    func getRecentlyVisitedMovieSelection(by index: Int) {
        let visitedMovies = movieVisitStore.entities
        let selectedVisitedMovie = visitedMovies[index]
        selectedRecentlyVisitedMovie?(selectedVisitedMovie.id, selectedVisitedMovie.title)
    }
    
}

// MARK: - View sections

extension SearchOptionsViewModel {
    
    enum SearchOptionsSection {
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
    
    func section(at index: Int) -> SearchOptionsSection {
        return viewState.value.sections[index]
    }
    
}

// MARK: - View states

extension SearchOptionsViewModel {
    
    enum SearchOptionsViewState {
        case emptyMovieVisits
        case populatedMovieVisits
        
        var sections: [SearchOptionsSection] {
            switch self {
            case .emptyMovieVisits:
                return [.defaultSearches, .genres]
            case .populatedMovieVisits:
                return [.recentlyVisited, .defaultSearches, .genres]
            }
        }
        
    }
    
}

// MARK: - SearchOptionsStoreDelegate

extension SearchOptionsViewModel: PersistenceStoreDelegate {
    
    func persistenceStore(willUpdateEntity shouldPrepare: Bool) {}
    
    func persistenceStore(didUpdateEntity update: Bool) {
        // If the state changed we reload the entire table view
        let viewStateChanged = configureViewState()
        if viewStateChanged {
            needsContentReload?()
        } else {
            let index = sectionIndex(for: .recentlyVisited)
            updateVisitedMovies?(index)
        }
        
    }
    
}

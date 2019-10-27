//
//  SearchOptionsViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/15/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class SearchOptionsViewModel {
    
    private var movieVisitUseCase: MovieVisitUseCaseProtocol
    
    let viewState: Bindable<SearchOptionsViewState> = Bindable(.emptyMovieVisits)
    
    var needsContentReload: (() -> Void)?
    var updateVisitedMovies: Bindable<Int?> = Bindable(nil)
    
    var selectedDefaultSearchOption: Bindable<DefaultSearchOption?> = Bindable(nil)
    var selectedMovieGenre: Bindable<Int?> = Bindable(nil)
    var selectedRecentlyVisitedMovie: ((Int, String) -> Void)?
    
    var visitedMovieCells: [VisitedMovieCellViewModel] {
        let visited = movieVisitUseCase.getMovieVisits()
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
    
    init(useCaseProvider: UseCaseProviderProtocol = UseCaseProvider()) {
        movieVisitUseCase = useCaseProvider.movieVisitUseCase()
        movieVisitUseCase.delegate = self
        configureViewState()
    }
    
    // MARK: - Private
    
    /**
     * Configures the state of the view according to the saved movie visits
     * quantity. Returns true if the state changed and false if not.
     */
    @discardableResult
    private func configureViewState() -> Bool {
        let oldViewState = viewState.value
        if movieVisitUseCase.hasMovieVisits() {
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
        selectedDefaultSearchOption.value = defaultSearchOption
    }
    
    func getMovieGenreSelection(by index: Int) {
        let genres = PersistenceManager.shared.genres
        let selectedGenre = genres[index]
        selectedMovieGenre.value = selectedGenre.id
    }
    
    func getRecentlyVisitedMovieSelection(by index: Int) {
        let visitedMovies = movieVisitUseCase.getMovieVisits()
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

// MARK: - MovieVisitUseCaseDelegate

extension SearchOptionsViewModel: MovieVisitUseCaseDelegate {
    
    func didUpdateMovieVisit() {
        // If the state changed we reload the entire table view
        let viewStateChanged = configureViewState()
        if viewStateChanged {
            needsContentReload?()
        } else {
            let index = sectionIndex(for: .recentlyVisited)
            updateVisitedMovies.value = index
        }
    }
    
}

// MARK: - Constants

extension SearchOptionsViewModel {
  
  struct Constants {
    static let recentlyVisitedSectionTitle = NSLocalizedString("recentlyVisitedSeearchSectionTitle", comment: "")
    static let genresSectionTitle = NSLocalizedString("movieGenresSearchSectionTitle", comment: "")
  }
  
}

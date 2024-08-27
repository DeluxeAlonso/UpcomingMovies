//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class SearchMoviesResultViewModel: SearchMoviesResultViewModelProtocol {

    // MARK: - Dependencies

    private var interactor: SearchMoviesResultInteractorProtocol

    // MARK: - Reactive properties

    let viewState = BehaviorBindable(SearchMoviesResultViewState.recentSearches).eraseToAnyBindable()
    let needsRefresh = PublishBindable<Void>().eraseToAnyBindable()

    // MARK: - Computed properties

    private var movies: [MovieProtocol] {
        viewState.value.currentSearchedMovies
    }

    var recentSearchCells: [RecentSearchCellViewModelProtocol] {
        recentSearches.map { RecentSearchCellViewModel(searchText: $0.searchText) }
    }

    var movieCells: [MovieListCellViewModelProtocol] {
        movies.compactMap { MovieListCellViewModel($0)}
    }

    var emptySearchResultsTitle: String {
        LocalizedStrings.emptySearchResults()
    }

    var recentSearchesTitle: String {
        LocalizedStrings.recentSearches()
    }

    // MARK: - Stored properties

    private var recentSearches: [MovieSearchProtocol] = [] {
        didSet {
            if viewState.value == .recentSearches {
                needsRefresh.send()
            }
        }
    }

    // MARK: - Initilalizers

    init(interactor: SearchMoviesResultInteractorProtocol) {
        self.interactor = interactor

        self.interactor.didUpdateMovieSearches = { [weak self] in
            guard let self = self else { return }
            self.loadRecentSearches()
        }
    }

    // MARK: - Movies handling

    func loadRecentSearches() {
        interactor.getMovieSearches(limit: 5) { [weak self] result in
            guard let self = self else { return }
            guard let recentSearches = result.wrappedValue else { return }

            self.recentSearches = recentSearches
        }
    }

    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
        interactor.saveSearchText(searchText, completion: nil)
        interactor.searchMovies(searchText: searchText,
                                page: nil,
                                completion: { result in
            switch result {
            case .success(let movies):
                self.viewState.value = movies.isEmpty ? .empty : .populated(movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }

    func clearMovies() {
        viewState.value = .recentSearches
    }

    // MARK: - Movie detail builder

    func searchedMovie(at index: Int) -> MovieProtocol {
        movies[index]
    }
}

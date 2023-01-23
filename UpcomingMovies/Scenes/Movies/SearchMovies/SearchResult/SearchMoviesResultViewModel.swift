//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class SearchMoviesResultViewModel: SearchMoviesResultViewModelProtocol {

    // MARK: - Dependencies

    private var interactor: SearchMoviesResultInteractorProtocol

    // MARK: - Reactive properties

    let viewState = BehaviorBindable(SearchMoviesResultViewState.recentSearches).eraseToAnyBindable()

    // MARK: - Computed properties

    private var movies: [Movie] {
        return viewState.value.currentSearchedMovies
    }

    var recentSearchCells: [RecentSearchCellViewModelProtocol] {
        return recentSearches.map { RecentSearchCellViewModel(searchText: $0.searchText) }
    }

    var movieCells: [MovieListCellViewModelProtocol] {
        return movies.compactMap { MovieCellViewModel($0)}
    }

    // MARK: - Stored properties

    private var recentSearches: [MovieSearch] = []

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
        interactor.getMovieSearches { [weak self] result in
            guard let self = self else { return }
            guard let recentSearches = try? result.get() else { return }

            self.recentSearches = recentSearches
            // TODO: - Create a bindable parameter to update recent searches cells
            if self.viewState.value == .recentSearches {
                self.viewState.value = .recentSearches
            }
        }
    }

    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
        interactor.saveSearchText(searchText, completion: nil)
        interactor.searchMovies(searchText: searchText,
                                  page: nil, completion: { result in
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

    func searchedMovie(at index: Int) -> Movie {
        return movies[index]
    }
}

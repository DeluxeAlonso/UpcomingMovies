//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SearchMoviesResultViewModel: SearchMoviesResultViewModelProtocol {
    
    // MARK: - Properties
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let movieUseCase: MovieUseCaseProtocol
    private var movieSearchUseCase: MovieSearchUseCaseProtocol
    
    private var authHandler: AuthenticationHandler
    
    private var movies: [Movie] = []
    
    let viewState: Bindable<SearchMoviesResultViewState> = Bindable(.initial)

    var updateRecentSearches: (() -> Void)?
    
    // MARK: - Computed Properties
    
    var recentSearchCells: [RecentSearchCellViewModel] {
        let searches = movieSearchUseCase.getMovieSearchs()
        return searches.map { RecentSearchCellViewModel(searchText: $0.searchText) }
    }
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0)}
    }
    
    // MARK: - Initilalizers
    
    init(useCaseProvider: UseCaseProviderProtocol,
         authHandler: AuthenticationHandler = AuthenticationHandler.shared) {
        self.useCaseProvider = useCaseProvider
        self.authHandler = authHandler
        self.movieUseCase = self.useCaseProvider.movieUseCase()
        self.movieSearchUseCase = self.useCaseProvider.movieSearchUseCase()
        self.movieSearchUseCase.didUpdateMovieSearch = { [weak self] in
            self?.updateRecentSearches?()
        }
    }
    
    // MARK: - Movies handling
    
    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
        movieSearchUseCase.save(with: searchText)
        let includeAdult = authHandler.currentUser()?.includeAdult ?? false
        movieUseCase.searchMovies(searchText: searchText,
                                  includeAdult: includeAdult,
                                  page: nil,
                                  completion: { result in
            switch result {
            case .success(let movies):
                self.processMovieResult(movies)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    private func processMovieResult(_ movies: [Movie]) {
        self.movies = movies
        if self.movies.isEmpty {
            viewState.value = .empty
        } else {
            viewState.value = .populated(self.movies)
        }
    }
    
    func resetViewState() {
        clearMovies()
        viewState.value = .initial
    }
    
    func clearMovies() {
        movies = []
    }
    
    // MARK: - Movie detail builder
    
    func searchedMovie(at index: Int) -> Movie {
        return movies[index]
    }
}

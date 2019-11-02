//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation
import Domain

final class SearchMoviesResultViewModel {
    
    // MARK: - Properties
    
    private let useCaseProvider: UseCaseProviderProtocol
    private var movieSearchUseCase: MovieSearchUseCaseProtocol
    
    private let movieClient = MovieClient()
    private var movies: [Movie] = []
    
    let viewState: Bindable<ViewState> = Bindable(.initial)

    var updateRecentSearches: (() -> Void)?
    
    // MARK: - Computed Properties
    
    var recentSearchCells: [RecentSearchCellViewModel] {
        let searches = movieSearchUseCase.getMovieSearchs()
        return searches.map { RecentSearchCellViewModel(searchText: $0.searchText) }
    }
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0, genreUseCase: useCaseProvider.genreUseCase())}
    }
    
    // MARK: - Initilalizers
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.useCaseProvider = useCaseProvider
        self.movieSearchUseCase = self.useCaseProvider.movieSearchUseCase()
        self.movieSearchUseCase.didUpdateMovieSearch = { [weak self] in
            self?.updateRecentSearches?()
        }
    }
    
    // MARK: - Movies handling
    
    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
        movieSearchUseCase.save(with: searchText)
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
        return MovieDetailViewModel(movies[index], useCaseProvider: useCaseProvider)
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

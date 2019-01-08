
//
//  SearchMoviesResultViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class SearchMoviesResultViewModel {
    
    private let movieClient = MovieClient()
    private var movies: [Movie] = []
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    let viewState: Bindable<SearchMoviesResultViewState> = Bindable(.initial)
    
    enum SearchMoviesResultViewState {
        
        case initial
        case empty
        case searching
        case populated([Movie])
        case error(Error)
        
    }
    
    // MARK: - Public
    
    func searchMovies(withSearchText searchText: String) {
        viewState.value = .searching
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
    
    func resetViewState() {
        clearMovies()
        viewState.value = .initial
    }
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index])
    }
    
    // MARK: - Private
    
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

}

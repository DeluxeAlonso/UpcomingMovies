//
//  UpcomingMoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

enum UpcomingMoviesViewState {
    
    case loading
    case paging([Movie], next: Int)
    case populated([Movie])
    case empty
    case error(Error)
    
    var currentMovies: [Movie] {
        switch self {
        case .populated(let movies):
            return movies
        case .paging(let movies, _):
            return movies
        case .loading, .empty, .error:
            return []
        }
    }
    
}

final class UpcomingMoviesViewModel {
    
    private let movieClient = MovieClient()
    
    let viewState: Bindable<UpcomingMoviesViewState> = Bindable(.loading)
    
    private var movies: [Movie] {
        return viewState.value.currentMovies
    }
    
    var movieCells: [UpcomingMovieCellViewModel] {
        return movies.compactMap { UpcomingMovieCellViewModel($0) }
    }
    
    var selectedMovieCell: UpcomingMovieCellViewModel?
    
    // MARK: - Public
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index])
    }
    
    func getUpcomingMovies() {
        movieClient.getUpcomingMovies(page: getCurrentPage()) { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self.processMovieResult(movieResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    func getCurrentPage() -> Int {
        switch viewState.value {
        case .populated, .empty, .error, .loading:
            return 1
        case .paging(_, let page):
            return page
        }
    }
    
    func setSelectedMovie(at index: Int) {
        selectedMovieCell = movieCells[index]
    }
    
    // MARK: - Private
    
    private func processMovieResult(_ movieResult: MovieResult) {
        guard let fetchedMovies = movieResult.results else {
            return
        }
        var allMovies = viewState.value.currentMovies
        allMovies.append(contentsOf: fetchedMovies)
        if movieResult.hasMorePages {
            viewState.value = .paging(allMovies, next: movieResult.nextPage)
        } else {
            viewState.value = .populated(allMovies)
        }
    }

}

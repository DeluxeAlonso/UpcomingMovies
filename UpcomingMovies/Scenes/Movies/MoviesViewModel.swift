//
//  MoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum MovieListFilter {
    case upcoming, popular, topRated
    case similar(movieId: Int)
    case byGenre(genreId: Int)
    
    var title: String? {
        switch self {
        case .upcoming:
            return "Upcoming Movies"
        case .popular:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
        case .similar:
            return "Similar Movies"
        case .byGenre(let genreId):
            let genres = AppManager.shared.genres
            let genre = genres.filter { $0.id == genreId }.first
            return genre?.name
        }
    }
}

protocol MoviesViewModel {
    
    associatedtype MovieCellViewModel
    
    var movieClient: MovieClient { get }
    var viewState: Bindable<SimpleViewState<Movie>> { get set }
    var filter: MovieListFilter { get set }
    
    var movieCells: [MovieCellViewModel] { get }
    var movies: [Movie] { get }
    
    var startLoading: ((Bool) -> Void)? { get set }
    
}

extension MoviesViewModel {
    
    var movies: [Movie] {
        return viewState.value.currentEntities
    }
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index])
    }
    
    func getMovies() {
        startLoading?(true)
        fetchMovies(currentPage: viewState.value.currentPage, filter: filter)
    }
    
    func refreshMovies() {
        fetchMovies(currentPage: 1, filter: filter)
    }
    
    func fetchMovies(currentPage: Int, filter: MovieListFilter) {
        movieClient.getMovies(page: currentPage, filter: filter, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self.processMovieResult(movieResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        })
    }
    
    func processMovieResult(_ movieResult: MovieResult) {
        startLoading?(false)
        let fetchedMovies = movieResult.results
        var allMovies = movieResult.currentPage == 1 ? [] : viewState.value.currentEntities
        allMovies.append(contentsOf: fetchedMovies)
        if movieResult.hasMorePages {
            viewState.value = .paging(allMovies, next: movieResult.nextPage)
        } else {
            viewState.value = .populated(allMovies)
        }
    }
    
}

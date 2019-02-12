//
//  MoviesViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/6/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

enum MoviesViewState {
    
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

enum MovieListFilter {
    case upcoming, popular, topRated
    case byGenre(genreId: Int)
    
    var title: String? {
        switch self {
        case .upcoming:
            return "Upcoming Movies"
        case .popular:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
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
    var viewState: Bindable<MoviesViewState> { get set }
    var filter: MovieListFilter { get set }
    
    var movieCells: [MovieCellViewModel] { get }
    var movies: [Movie] { get }
    
}

extension MoviesViewModel {
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        return MovieDetailViewModel(movies[index])
    }
    
    func getMovies() {
        fetchMovies(currentPage: getCurrentPage(), filter: filter)
    }
    
    func refreshMovies() {
        fetchMovies(currentPage: 1, filter: filter)
    }
    
    func getCurrentPage() -> Int {
        switch viewState.value {
        case .populated, .empty, .error, .loading:
            return 1
        case .paging(_, let page):
            return page
        }
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
        let fetchedMovies = movieResult.results
        var allMovies = movieResult.currentPage == 1 ? [] : viewState.value.currentMovies
        allMovies.append(contentsOf: fetchedMovies)
        if movieResult.hasMorePages {
            viewState.value = .paging(allMovies, next: movieResult.nextPage)
        } else {
            viewState.value = .populated(allMovies)
        }
    }
    
}

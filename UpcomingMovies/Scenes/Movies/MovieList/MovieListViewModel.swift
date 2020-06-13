//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/23/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieListViewModel: MoviesViewModel {
    
    var useCaseProvider: UseCaseProviderProtocol
    var movieUseCase: MovieUseCaseProtocol
    var contentHandler: MoviesContentHandlerProtocol
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    // MARK: - Computed Properties
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol, contentHandler: MoviesContentHandlerProtocol) {
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.contentHandler = contentHandler
    }
    
}

protocol MoviesContentHandlerProtocol {
    var displayTitle: String { get }
    
    func getMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void)
}

struct UpcomingMoviesContentHandler: MoviesContentHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    
    var displayTitle: String {
        return "Upcoming Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getUpcomingMovies(page: page, completion: completion)
    }
}

struct TopRatedMoviesContentHandler: MoviesContentHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    
    var displayTitle: String {
        return "Top Rated Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getTopRatedMovies(page: page, completion: completion)
    }
}

struct PopularMoviesContentHandler: MoviesContentHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    
    var displayTitle: String {
        return "Popular Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getPopularMovies(page: page, completion: completion)
    }
}

struct SimilarMoviesContentHandler: MoviesContentHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    let movieId: Int
    
    var displayTitle: String {
        return "Similar Movies"
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getSimilarMovies(page: page, movieId: movieId, completion: completion)
    }
}

struct MoviesByGenreContentHandler: MoviesContentHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    let genreId: Int
    let genreName: String
    
    var displayTitle: String {
        return genreName
    }
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getMoviesByGenre(page: page, genreId: genreId, completion: completion)
    }
}

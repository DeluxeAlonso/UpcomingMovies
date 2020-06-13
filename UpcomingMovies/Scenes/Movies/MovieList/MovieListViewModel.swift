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
    var movieFetchHandler: MovieFetchHandlerProtocol
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    // MARK: - Computed Properties
    
    var movieCells: [MovieCellViewModel] {
        return movies.compactMap { MovieCellViewModel($0) }
    }
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol, movieFetchHandler: MovieFetchHandlerProtocol) {
        self.useCaseProvider = useCaseProvider
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.movieFetchHandler = movieFetchHandler
    }
    
}

protocol MovieFetchHandlerProtocol {
    func getMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void)
}

struct UpcomingMoviesFetchHandler: MovieFetchHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getUpcomingMovies(page: page, completion: completion)
    }
}

struct TopRatedMoviesFetchHandler: MovieFetchHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getTopRatedMovies(page: page, completion: completion)
    }
}

struct PopularMoviesFetchHandler: MovieFetchHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getPopularMovies(page: page, completion: completion)
    }
}

struct SimilarMoviesFetchHandler: MovieFetchHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    let movieId: Int
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getSimilarMovies(page: page, movieId: movieId, completion: completion)
    }
}

struct MoviesByGenreFetchHandler: MovieFetchHandlerProtocol {
    let movieUseCase: MovieUseCaseProtocol
    let genreId: Int
    
    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getMoviesByGenre(page: page, genreId: genreId, completion: completion)
    }
}

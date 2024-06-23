//
//  SimilarMoviesInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct SimilarMoviesInteractor: MoviesInteractorProtocol {

    let movieUseCase: MovieUseCaseProtocol
    let movieId: Int

    init(movieUseCase: MovieUseCaseProtocol, movieId: Int) {
        self.movieUseCase = movieUseCase
        self.movieId = movieId
    }

    func getMovies(page: Int, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        movieUseCase.getSimilarMovies(page: page, movieId: movieId, completion: { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

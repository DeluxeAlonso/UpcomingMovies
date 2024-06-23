//
//  TopRatedMoviesInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct TopRatedMoviesInteractor: MoviesInteractorProtocol {

    let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }

    func getMovies(page: Int, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        movieUseCase.getTopRatedMovies(page: page, completion: { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

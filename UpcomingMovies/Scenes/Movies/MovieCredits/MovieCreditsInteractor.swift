//
//  MovieCreditsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class MovieCreditsInteractor: MovieCreditsInteractorProtocol {

    private let movieUseCase: MovieUseCaseProtocol

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }

    func getMovieCredits(for movieId: Int, page: Int?,
                         completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        movieUseCase.getMovieCredits(for: movieId, page: page, completion: completion)
    }

}

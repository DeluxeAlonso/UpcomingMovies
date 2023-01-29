//
//  SimilarMoviesContentHandler.swift
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

    init(useCaseProvider: UseCaseProviderProtocol, movieId: Int) {
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.movieId = movieId
    }

    // TODO: - Move this to a view model
    var displayTitle: String {
        "Similar Movies"
    }

    func getMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        movieUseCase.getSimilarMovies(page: page, movieId: movieId, completion: completion)
    }
}

//
//  MovieReviewsInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/29/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class MovieReviewsInteractor: MovieReviewsInteractorProtocol {

    private let movieUseCase: MovieUseCaseProtocol

    init(useCaseProvider: UseCaseProviderProtocol) {
        self.movieUseCase = useCaseProvider.movieUseCase()
    }

    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        movieUseCase.getMovieReviews(for: movieId, page: page, completion: completion)
    }

}

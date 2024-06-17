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

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }

    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[ReviewProtocol], Error>) -> Void) {
        movieUseCase.getMovieReviews(for: movieId, page: page, completion: { result in
            switch result {
            case .success(let reviews):
                completion(.success(reviews.map(ReviewModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })

    }

}

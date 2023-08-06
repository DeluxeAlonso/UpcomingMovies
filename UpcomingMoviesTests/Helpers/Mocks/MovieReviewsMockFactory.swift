//
//  MovieReviewsMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/29/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MockMovieReviewsInteractor: MovieReviewsInteractorProtocol {

    var getMovieReviewsResult: Result<[Review], Error>?
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        if let getMovieReviewsResult {
            completion(getMovieReviewsResult)
        }
    }

}

//
//  MovieReviewsMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/29/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

final class MockMovieReviewsInteractor: MovieReviewsInteractorProtocol {
    
    var getMovieReviewsResult: Result<[Review], Error>?
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        completion(getMovieReviewsResult!)
    }
    
}

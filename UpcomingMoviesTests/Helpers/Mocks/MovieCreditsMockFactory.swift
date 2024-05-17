//
//  MovieCreditsMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MockMovieCreditsInteractor: MovieCreditsInteractorProtocol {

    var getMovieCreditsResult: Result<MovieCreditsProtocol, Error>?
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<MovieCreditsProtocol, Error>) -> Void) {
        if let getMovieCreditsResult {
            completion(getMovieCreditsResult)
        }
    }

}

final class MockMovieCreditsFactory: MovieCreditsFactoryProtocol {

    var sections: [MovieCreditsCollapsibleSection] = []

}

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

final class MockMovieCreditsSectionManager: MovieCreditsSectionManagerProtocol {

    var sections: [MovieCreditsCollapsibleSection] = []

    private(set) var updateSectionCallCount = 0
    func updateSection(type: UpcomingMovies.MovieCreditsViewSection, enabled: Bool) {
        updateSectionCallCount += 1
    }

    private(set) var toggleSectionCallCount = 0
    func toggleSection(at index: Int) {
        toggleSectionCallCount += 1
    }

}

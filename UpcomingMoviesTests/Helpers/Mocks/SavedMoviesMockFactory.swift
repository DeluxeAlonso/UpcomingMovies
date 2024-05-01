//
//  SavedMoviesMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MockSavedMoviesInteractor: SavedMoviesInteractorProtocol {

    var getSavedMoviesResult: Result<[MovieProtocol], Error>?
    func getSavedMovies(page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        if let getSavedMoviesResult {
            completion(getSavedMoviesResult)
        }
    }

}

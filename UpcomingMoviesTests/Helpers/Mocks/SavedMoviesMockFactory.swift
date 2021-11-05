//
//  SavedMoviesMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 7/24/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MockSavedMoviesInteractor: SavedMoviesInteractorProtocol {

    var getSavedMoviesResult: Result<[Movie], Error>?
    func getSavedMovies(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(getSavedMoviesResult!)
    }

}

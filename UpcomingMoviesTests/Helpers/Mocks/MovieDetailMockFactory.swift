//
//  MovieDetailMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MockMovieDetailInteractor: MovieDetailInteractorProtocol {

    var isUserSignedInResult: Bool? = false
    func isUserSignedIn() -> Bool {
        return isUserSignedInResult!
    }

    var findGenreResult: Result<Genre?, Error>? = .success(nil)
    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        completion(findGenreResult!)
    }

    var getMovieDetailResult: Result<Movie, Error>?
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        completion(getMovieDetailResult!)
    }

    var getMovieAccountStateResult: Result<Movie.AccountState, Error>?
    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<Movie.AccountState, Error>) -> Void) {
        completion(getMovieAccountStateResult!)
    }

    var markMovieAsFavoriteResult: Result<Bool, Error>?
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(markMovieAsFavoriteResult!)
    }

    var addToWatchlistResult: Result<Bool, Error>?
    func addToWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(addToWatchlistResult!)
    }

    var removeFromWatchlistResult: Result<Bool, Error>?
    func removeFromWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(removeFromWatchlistResult!)
    }

    func saveMovieVisit(with id: Int, title: String, posterPath: String?) {}

}

class MockMovieDetailViewFactory: MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] = []

}

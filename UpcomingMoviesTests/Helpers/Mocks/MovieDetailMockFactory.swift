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

    var isUserSignedInResult: Bool = false
    func isUserSignedIn() -> Bool {
        isUserSignedInResult
    }

    var findGenreResult: Result<Genre?, Error>? = .success(nil)
    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        if let findGenreResult {
            completion(findGenreResult)
        }
    }

    var getMovieDetailResult: Result<Movie, Error>?
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        if let getMovieDetailResult {
            completion(getMovieDetailResult)
        }
    }

    var getMovieAccountStateResult: Result<Movie.AccountState, Error>?
    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<Movie.AccountState, Error>) -> Void) {
        if let getMovieAccountStateResult {
            completion(getMovieAccountStateResult)
        }
    }

    var markMovieAsFavoriteResult: Result<Bool, Error>?
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let markMovieAsFavoriteResult {
            completion(markMovieAsFavoriteResult)
        }
    }

    var addToWatchlistResult: Result<Bool, Error>?
    func addToWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let addToWatchlistResult {
            completion(addToWatchlistResult)
        }
    }

    var removeFromWatchlistResult: Result<Bool, Error>?
    func removeFromWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let removeFromWatchlistResult {
            completion(removeFromWatchlistResult)
        }
    }

    func saveMovieVisit(with id: Int, title: String, posterPath: String?) {}

}

class MockMovieDetailViewFactory: MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] = []

}

//
//  MovieDetailMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
import UpcomingMoviesDomain

final class MockMovieDetailInteractor: MovieDetailInteractorProtocol {

    var isUserSignedInResult: Bool = false
    private(set) var isUserSignedInCallCount = 0
    func isUserSignedIn() -> Bool {
        isUserSignedInCallCount += 1
        return isUserSignedInResult
    }

    var findGenreResult: Result<Genre?, Error>? = .success(nil)
    private(set) var findGenreCallCount = 0
    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        if let findGenreResult {
            completion(findGenreResult)
        }
        findGenreCallCount += 1
    }

    var findGenresResult: Result<[Genre], Error>? = .success([])
    private(set) var findGenresCallCount = 0
    func findGenres(for identifiers: [Int], completion: @escaping (Result<[Genre], Error>) -> Void) {
        if let findGenresResult {
            completion(findGenresResult)
        }
        findGenresCallCount += 1
    }

    var getMovieDetailResult: Result<MovieProtocol, Error>?
    private(set) var getMovieDetailCallCount = 0
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<MovieProtocol, Error>) -> Void) {
        if let getMovieDetailResult {
            completion(getMovieDetailResult)
        }
        getMovieDetailCallCount += 1
    }

    var getMovieAccountStateResult: Result<Movie.AccountState, Error>?
    private(set) var getMovieAccountStateCallCount = 0
    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<Movie.AccountState, Error>) -> Void) {
        if let getMovieAccountStateResult {
            completion(getMovieAccountStateResult)
        }
        getMovieAccountStateCallCount += 1
    }

    var markMovieAsFavoriteResult: Result<Bool, Error>?
    private(set) var markMovieAsFavoriteCallCount = 0
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let markMovieAsFavoriteResult {
            completion(markMovieAsFavoriteResult)
        }
        markMovieAsFavoriteCallCount += 1
    }

    var addToWatchlistResult: Result<Bool, Error>?
    private(set) var addToWatchlistCallCount = 0
    func addToWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let addToWatchlistResult {
            completion(addToWatchlistResult)
        }
        addToWatchlistCallCount += 1
    }

    var removeFromWatchlistResult: Result<Bool, Error>?
    private(set) var removeFromWatchlistCallCount = 0
    func removeFromWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let removeFromWatchlistResult {
            completion(removeFromWatchlistResult)
        }
        removeFromWatchlistCallCount += 1
    }

    private(set) var saveMovieVisitCallCount = 0
    func saveMovieVisit(with id: Int, title: String, posterPath: String?) {
        saveMovieVisitCallCount += 1
    }

}

final class MockMovieDetailViewFactory: MovieDetailFactoryProtocol {

    var options: [MovieDetailOption] = []

}

final class MockMovieDetailPosterViewControllerDelegate: MockViewController, MovieDetailPosterViewControllerDelegate {

    var transitionContainerViewCallCount = 0
    func movieDetailPosterViewController(_ movieDetailPosterViewController: UpcomingMovies.MovieDetailPosterViewController,
                                         transitionContainerView: UIView) {
        transitionContainerViewCallCount += 1
    }

}

final class MockMovieDetailOptionsViewControllerDelegate: MockViewController, MovieDetailOptionsViewControllerDelegate {

    var didSelectOptionCallCount = 0
    func movieDetailOptionsViewController(_ movieDetailOptionsViewController: UpcomingMovies.MovieDetailOptionsViewController,
                                          didSelectOption option: UpcomingMovies.MovieDetailOption) {
        didSelectOptionCallCount += 1
    }

}

final class MockMovieDetailOptionsViewModel: MovieDetailOptionsViewModelProtocol {

    var options: [MovieDetailOption] = []

}

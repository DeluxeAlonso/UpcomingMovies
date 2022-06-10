//
//  MovieUseCaseProtocolMock.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 1/06/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation
@testable import UpcomingMovies
@testable import UpcomingMoviesDomain
@testable import UpcomingMoviesData
@testable import NetworkInfrastructure

final class MovieUseCaseProtocolMock: MovieUseCaseProtocol {

    var getUpcomingMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getUpcomingMoviesCalled = false
    var getUpcomingMoviesCallCount = 0
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getUpcomingMoviesResult = getUpcomingMoviesResult {
            completion(getUpcomingMoviesResult)
        }
        getUpcomingMoviesCalled = true
        getUpcomingMoviesCallCount += 1
    }

    var getPopularMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getPopularMoviesCalled = false
    var getPopularMoviesCallCount = 0
    func getPopularMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getPopularMoviesResult = getPopularMoviesResult {
            completion(getPopularMoviesResult)
        }
        getPopularMoviesCalled = true
        getPopularMoviesCallCount += 1
    }

    var getTopRatedMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getTopRatedMoviesCalled = false
    var getTopRatedMoviesCallCount = 0
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getTopRatedMoviesResult = getTopRatedMoviesResult {
            completion(getTopRatedMoviesResult)
        }
        getTopRatedMoviesCalled = true
        getTopRatedMoviesCallCount += 1
    }

    var getMoviesByGenreResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getMoviesByGenreCalled = false
    var getMoviesByGenreCallCount = 0
    func getMoviesByGenre(page: Int, genreId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getMoviesByGenreCalled = true
        getMoviesByGenreCallCount += 1
    }

    var getSimilarMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getSimilarMoviesCalled = false
    var getSimilarMoviesCallCount = 0
    func getSimilarMovies(page: Int, movieId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getSimilarMoviesCalled = true
        getSimilarMoviesCallCount += 1
    }

    var getMovieDetailResult: Result<UpcomingMoviesDomain.Movie, Error>?
    var getMovieDetailCalled = false
    var getMovieDetailCallCount = 0
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie, Error>) -> Void) {
        if let getMovieDetailResult = getMovieDetailResult {
            completion(getMovieDetailResult)
        }
        getMovieDetailCalled = true
        getMovieDetailCallCount += 1
    }

    var searchMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var searchMoviesCalled = false
    var searchMoviesCallCount = 0
    func searchMovies(searchText: String, includeAdult: Bool, page: Int?,
                      completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let searchMoviesResult = searchMoviesResult {
            completion(searchMoviesResult)
        }
        searchMoviesCalled = true
        searchMoviesCallCount += 1
    }

    var getMovieReviewsResult: Result<[UpcomingMoviesDomain.Review], Error>?
    var getMovieReviewsCalled = false
    var getMovieReviewsCallCount = 0
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Review], Error>) -> Void) {
        if let getMovieReviewsResult = getMovieReviewsResult {
            completion(getMovieReviewsResult)
        }
        getMovieReviewsCalled = true
        getMovieReviewsCallCount += 1
    }

    var getMovieVideosResult: Result<[UpcomingMoviesDomain.Video], Error>?
    var getMovieVideosCalled = false
    var getMovieVideosCallCount = 0
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Video], Error>) -> Void) {
        if let getMovieVideosResult = getMovieVideosResult {
            completion(getMovieVideosResult)
        }
        getMovieVideosCalled = true
        getMovieVideosCallCount += 1
    }

    var getMovieCreditsResult: Result<UpcomingMoviesDomain.MovieCredits, Error>?
    var getMovieCreditsCalled = false
    var getMovieCreditsCallCount = 0
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<UpcomingMoviesDomain.MovieCredits, Error>) -> Void) {
        if let getMovieCreditsResult = getMovieCreditsResult {
            completion(getMovieCreditsResult)
        }
        getMovieCreditsCalled = true
        getMovieCreditsCallCount += 1
    }

    var getMovieAccountStateResult: Result<UpcomingMoviesDomain.Movie.AccountState, Error>?
    var getMovieAccountStateCalled = false
    var getMovieAccountStateCallCount = 0
    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie.AccountState, Error>) -> Void) {
        if let getMovieAccountStateResult = getMovieAccountStateResult {
            completion(getMovieAccountStateResult)
        }
        getMovieAccountStateCalled = true
        getMovieAccountStateCallCount += 1
    }

    var rateMovieResult: Result<Void, Error>?
    var rateMovieCalled = false
    var rateMovieCallCount = 0
    func rateMovie(movieId: Int, value: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        if let rateMovieResult = rateMovieResult {
            completion(rateMovieResult)
        }
        rateMovieCalled = true
        rateMovieCallCount += 1
    }

}

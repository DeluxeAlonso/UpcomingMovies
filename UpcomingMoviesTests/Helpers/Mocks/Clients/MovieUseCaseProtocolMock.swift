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
    private (set) var getUpcomingMoviesCallCount = 0
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getUpcomingMoviesResult = getUpcomingMoviesResult {
            completion(getUpcomingMoviesResult)
        }
        getUpcomingMoviesCallCount += 1
    }

    var getPopularMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    private (set) var getPopularMoviesCallCount = 0
    func getPopularMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getPopularMoviesResult = getPopularMoviesResult {
            completion(getPopularMoviesResult)
        }
        getPopularMoviesCallCount += 1
    }

    var getTopRatedMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    private (set) var getTopRatedMoviesCallCount = 0
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getTopRatedMoviesResult = getTopRatedMoviesResult {
            completion(getTopRatedMoviesResult)
        }
        getTopRatedMoviesCallCount += 1
    }

    var getMoviesByGenreResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    private (set) var getMoviesByGenreCallCount = 0
    func getMoviesByGenre(page: Int, genreId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getMoviesByGenreCallCount += 1
    }

    var getSimilarMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    private (set) var getSimilarMoviesCallCount = 0
    func getSimilarMovies(page: Int, movieId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getSimilarMoviesCallCount += 1
    }

    var getMovieDetailResult: Result<UpcomingMoviesDomain.Movie, Error>?
    private (set) var getMovieDetailCallCount = 0
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie, Error>) -> Void) {
        if let getMovieDetailResult = getMovieDetailResult {
            completion(getMovieDetailResult)
        }
        getMovieDetailCallCount += 1
    }

    var searchMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    private (set)  var searchMoviesCallCount = 0
    func searchMovies(searchText: String, includeAdult: Bool, page: Int?,
                      completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let searchMoviesResult = searchMoviesResult {
            completion(searchMoviesResult)
        }
        searchMoviesCallCount += 1
    }

    var getMovieReviewsResult: Result<[UpcomingMoviesDomain.Review], Error>?
    private (set) var getMovieReviewsCallCount = 0
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Review], Error>) -> Void) {
        if let getMovieReviewsResult = getMovieReviewsResult {
            completion(getMovieReviewsResult)
        }
        getMovieReviewsCallCount += 1
    }

    var getMovieVideosResult: Result<[UpcomingMoviesDomain.Video], Error>?
    private (set) var getMovieVideosCallCount = 0
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Video], Error>) -> Void) {
        if let getMovieVideosResult = getMovieVideosResult {
            completion(getMovieVideosResult)
        }
        getMovieVideosCallCount += 1
    }

    var getMovieCreditsResult: Result<UpcomingMoviesDomain.MovieCredits, Error>?
    private (set) var getMovieCreditsCallCount = 0
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<UpcomingMoviesDomain.MovieCredits, Error>) -> Void) {
        if let getMovieCreditsResult = getMovieCreditsResult {
            completion(getMovieCreditsResult)
        }
        getMovieCreditsCallCount += 1
    }

    var getMovieAccountStateResult: Result<UpcomingMoviesDomain.Movie.AccountState, Error>?
    private (set) var getMovieAccountStateCallCount = 0
    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie.AccountState, Error>) -> Void) {
        if let getMovieAccountStateResult = getMovieAccountStateResult {
            completion(getMovieAccountStateResult)
        }
        getMovieAccountStateCallCount += 1
    }

    var rateMovieResult: Result<Void, Error>?
    private (set) var rateMovieCallCount = 0
    func rateMovie(movieId: Int, value: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        if let rateMovieResult = rateMovieResult {
            completion(rateMovieResult)
        }
        rateMovieCallCount += 1
    }

}

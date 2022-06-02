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
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getUpcomingMoviesResult = getUpcomingMoviesResult {
            completion(getUpcomingMoviesResult)
        }
        getUpcomingMoviesCalled = true
    }

    var getPopularMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getPopularMoviesCalled = false
    func getPopularMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getPopularMoviesResult = getPopularMoviesResult {
            completion(getPopularMoviesResult)
        }
        getPopularMoviesCalled = true
    }

    var getTopRatedMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getTopRatedMoviesCalled = false
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getTopRatedMoviesResult = getTopRatedMoviesResult {
            completion(getTopRatedMoviesResult)
        }
        getTopRatedMoviesCalled = true
    }

    var getMoviesByGenreResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getMoviesByGenreCalled = false
    func getMoviesByGenre(page: Int, genreId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getMoviesByGenreCalled = true
    }

    var getSimilarMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var getSimilarMoviesCalled = false
    func getSimilarMovies(page: Int, movieId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getMoviesByGenreCalled = true
    }

    var getMovieDetailResult: Result<UpcomingMoviesDomain.Movie, Error>?
    var getMovieDetailCalled = false
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie, Error>) -> Void) {
        if let getMovieDetailResult = getMovieDetailResult {
            completion(getMovieDetailResult)
        }
        getMovieDetailCalled = true
    }

    var searchMoviesResult: Result<[UpcomingMoviesDomain.Movie], Error>?
    var searchMoviesCalled = false
    func searchMovies(searchText: String, includeAdult: Bool, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        if let searchMoviesResult = searchMoviesResult {
            completion(searchMoviesResult)
        }
        searchMoviesCalled = true
    }

    var getMovieReviewsResult: Result<[UpcomingMoviesDomain.Review], Error>?
    var getMovieReviewsCalled = false
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Review], Error>) -> Void) {
        if let getMovieReviewsResult = getMovieReviewsResult {
            completion(getMovieReviewsResult)
        }
        getMovieReviewsCalled = true
    }

    var getMovieVideosResult: Result<[UpcomingMoviesDomain.Video], Error>?
    var getMovieVideosCalled = false
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Video], Error>) -> Void) {
        if let getMovieVideosResult = getMovieVideosResult {
            completion(getMovieVideosResult)
        }
        getMovieVideosCalled = true
    }

    var getMovieCreditsResult: Result<UpcomingMoviesDomain.MovieCredits, Error>?
    var getMovieCreditsCalled = false
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<UpcomingMoviesDomain.MovieCredits, Error>) -> Void) {
        if let getMovieCreditsResult = getMovieCreditsResult {
            completion(getMovieCreditsResult)
        }
        getMovieCreditsCalled = true
    }

    var getMovieAccountStateResult: Result<UpcomingMoviesDomain.Movie.AccountState, Error>?
    var getMovieAccountStateCalled = false
    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<UpcomingMoviesDomain.Movie.AccountState, Error>) -> Void) {
        if let getMovieAccountStateResult = getMovieAccountStateResult {
            completion(getMovieAccountStateResult)
        }
        getMovieAccountStateCalled = true
    }

    var rateMovieResult: Result<Void, Error>?
    var rateMovieCalled = false
    func rateMovie(movieId: Int, value: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        if let rateMovieResult = rateMovieResult {
            completion(rateMovieResult)
        }
        rateMovieCalled = true
    }

}

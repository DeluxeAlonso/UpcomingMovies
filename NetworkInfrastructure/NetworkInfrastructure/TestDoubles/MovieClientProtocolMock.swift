//
//  MovieClientProtocolMock.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 20/09/23.
//

import UpcomingMoviesDomain

final class MovieClientProtocolMock: MovieClientProtocol {

    var getUpcomingMoviesResult: Result<MovieResult?, APIError>?
    private(set) var getUpcomingMoviesCallCount = 0
    func getUpcomingMovies(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getUpcomingMoviesResult = getUpcomingMoviesResult {
            completion(getUpcomingMoviesResult)
        }
        getUpcomingMoviesCallCount += 1
    }

    var getPopularMoviesResult: Result<MovieResult?, APIError>?
    private(set) var getPopularMoviesCallCount = 0
    func getPopularMovies(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getPopularMoviesResult = getPopularMoviesResult {
            completion(getPopularMoviesResult)
        }
        getPopularMoviesCallCount += 1
    }

    var getTopRatedMoviesResult: Result<MovieResult?, APIError>?
    private(set) var getTopRatedMoviesCallCount = 0
    func getTopRatedMovies(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getTopRatedMoviesResult = getTopRatedMoviesResult {
            completion(getTopRatedMoviesResult)
        }
        getTopRatedMoviesCallCount += 1
    }

    var getSimilarMoviesResult: Result<MovieResult?, APIError>?
    private(set) var getSimilarMoviesCallCount = 0
    func getSimilarMovies(page: Int, movieId: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getSimilarMoviesResult = getSimilarMoviesResult {
            completion(getSimilarMoviesResult)
        }
        getSimilarMoviesCallCount += 1
    }

    var getMoviesByGenreResult: Result<MovieResult?, APIError>?
    private(set) var getMoviesByGenreCallCount = 0
    func getMoviesByGenre(page: Int, genreId: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let getMoviesByGenreResult = getMoviesByGenreResult {
            completion(getMoviesByGenreResult)
        }
        getMoviesByGenreCallCount += 1
    }

    var searchMoviesResult: Result<MovieResult?, APIError>?
    private(set) var searchMoviesCallCount = 0
    func searchMovies(searchText: String, includeAdult: Bool, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        if let searchMoviesResult = searchMoviesResult {
            completion(searchMoviesResult)
        }
        searchMoviesCallCount += 1
    }

    var getMovieDetailResult: Result<MovieDetailResult, APIError>?
    private(set) var getMovieDetailCallCount = 0
    func getMovieDetail(with movieId: Int, completion: @escaping (Result<MovieDetailResult, APIError>) -> Void) {
        if let getMovieDetailResult = getMovieDetailResult {
            completion(getMovieDetailResult)
        }
        getMovieDetailCallCount += 1
    }

    var getMovieVideosResult: Result<VideoResult?, APIError>?
    private(set) var getMovieVideosCallCount = 0
    func getMovieVideos(with movieId: Int, completion: @escaping (Result<VideoResult?, APIError>) -> Void) {
        if let getMovieVideosResult = getMovieVideosResult {
            completion(getMovieVideosResult)
        }
        getMovieVideosCallCount += 1
    }

    var getMovieReviewsResult: Result<ReviewResult?, APIError>?
    private(set) var getMovieReviewsCallCount = 0
    func getMovieReviews(page: Int, with movieId: Int, completion: @escaping (Result<ReviewResult?, APIError>) -> Void) {
        if let getMovieReviewsResult = getMovieReviewsResult {
            completion(getMovieReviewsResult)
        }
        getMovieReviewsCallCount += 1
    }

    var getMovieCreditsResult: Result<CreditResult?, APIError>?
    private(set) var getMovieCreditsCallCount = 0
    func getMovieCredits(with movieId: Int, completion: @escaping (Result<CreditResult?, APIError>) -> Void) {
        if let getMovieCreditsResult = getMovieCreditsResult {
            completion(getMovieCreditsResult)
        }
        getMovieCreditsCallCount += 1
    }

    var getMovieAccountStateResult: Result<MovieAccountStateResult?, APIError>?
    private(set) var getMovieAccountStateCallCount = 0
    func getMovieAccountState(with movieId: Int, sessionId: String, completion: @escaping (Result<MovieAccountStateResult?, APIError>) -> Void) {
        if let getMovieAccountStateResult = getMovieAccountStateResult {
            completion(getMovieAccountStateResult)
        }
        getMovieAccountStateCallCount += 1
    }

    var rateMovieResult: Result<RateMovieResult?, APIError>?
    private(set) var rateMovieCallCount = 0
    func rateMovie(movieId: Int, sessionId: String, value: Double, completion: @escaping (Result<RateMovieResult?, APIError>) -> Void) {
        if let rateMovieResult = rateMovieResult {
            completion(rateMovieResult)
        }
        rateMovieCallCount += 1
    }

}

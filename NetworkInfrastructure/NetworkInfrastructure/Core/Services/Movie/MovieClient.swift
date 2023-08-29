//
//  MovieClient.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

final class MovieClient: APIClient, MovieClientProtocol {

    let session: URLSession

    // MARK: - Initializers

    init(session: URLSession) {
        self.session = session
    }

    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        self.init(session: session)
    }

    // MARK: - Movie list

    func getUpcomingMovies(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = MovieProvider.getUpcoming(page: page).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    func getPopularMovies(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = MovieProvider.getPopular(page: page).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    func getTopRatedMovies(page: Int, completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = MovieProvider.getTopRated(page: page).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    func getSimilarMovies(page: Int, movieId: Int,
                          completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = MovieProvider.getSimilars(page: page, id: movieId).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    func getMoviesByGenre(page: Int, genreId: Int,
                          completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        let request = MovieProvider.getByGenreId(page: page, genreId: genreId).request
        fetch(with: request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    // MARK: - Movie search

    func searchMovies(searchText: String,
                      includeAdult: Bool,
                      completion: @escaping (Result<MovieResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.search(searchText: searchText, includeAdult: includeAdult).request, decode: { json -> MovieResult? in
            guard let movieResult = json as? MovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }

    // MARK: - Movie detail

    func getMovieDetail(with movieId: Int, completion: @escaping (Result<MovieDetailResult, APIError>) -> Void) {
        fetch(with: MovieProvider.getDetail(id: movieId).request,
              decode: { json -> MovieDetailResult? in
                guard let movie = json as? MovieDetailResult else { return nil }
                return movie
              }, completion: completion)
    }

    // MARK: - Movie videos

    func getMovieVideos(with movieId: Int, completion: @escaping (Result<VideoResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getVideos(id: movieId).request, decode: { json -> VideoResult? in
            guard let videoResult = json as? VideoResult else { return nil }
            return videoResult
        }, completion: completion)
    }

    // MARK: - Movie reviews

    func getMovieReviews(page: Int, with movieId: Int, completion: @escaping (Result<ReviewResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getReviews(page: page, id: movieId).request, decode: { json -> ReviewResult? in
            guard let reviewResult = json as? ReviewResult else { return nil }
            return reviewResult
        }, completion: completion)
    }

    // MARK: - Movie credits

    func getMovieCredits(with movieId: Int, completion: @escaping (Result<CreditResult?, APIError>) -> Void) {
        fetch(with: MovieProvider.getCredits(id: movieId).request, decode: { json -> CreditResult? in
            guard let reviewResult = json as? CreditResult else { return nil }
            return reviewResult
        }, completion: completion)
    }

    // MARK: - Movie Account State

    func getMovieAccountState(with movieId: Int, sessionId: String,
                              completion: @escaping (Result<MovieAccountStateResult?, APIError>) -> Void) {
        let request = MovieProvider.getAccountState(id: movieId, sessionId: sessionId).request
        fetch(with: request, decode: { json -> MovieAccountStateResult? in
            guard let accountStateResult = json as? MovieAccountStateResult else { return nil }
            return accountStateResult
        }, completion: completion)
    }

    // MARK: - Movie Rate

    func rateMovie(movieId: Int, sessionId: String, value: Double,
                   completion: @escaping (Result<RateMovieResult?, APIError>) -> Void) {
        let request =  MovieProvider.rateMovie(id: movieId, sessionId: sessionId, value: value).request
        fetch(with: request, decode: { json -> RateMovieResult? in
            guard let rateMovieResult = json as? RateMovieResult else { return nil }
            return rateMovieResult
        }, completion: completion)
    }

}

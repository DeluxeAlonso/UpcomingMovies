//
//  MovieRemoteDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public protocol MovieRemoteDataSourceProtocol: AnyObject {

    func getUpcomingMovies(page: Int,
                           completion: @escaping (Result<[Movie], Error>) -> Void)

    func getPopularMovies(page: Int,
                          completion: @escaping (Result<[Movie], Error>) -> Void)

    func getTopRatedMovies(page: Int,
                           completion: @escaping (Result<[Movie], Error>) -> Void)

    func getMoviesByGenre(page: Int,
                          genreId: Int,
                          completion: @escaping (Result<[Movie], Error>) -> Void)

    func getSimilarMovies(page: Int,
                          movieId: Int,
                          completion: @escaping (Result<[Movie], Error>) -> Void)

    func getMovieDetail(with movieId: Int,
                        completion: @escaping (Result<Movie, Error>) -> Void)

    func searchMovies(searchText: String, includeAdult: Bool, page: Int?,
                      completion: @escaping (Result<[Movie], Error>) -> Void)

    func getMovieReviews(for movieId: Int, page: Int?,
                         completion: @escaping (Result<[Review], Error>) -> Void)

    func getMovieVideos(for movieId: Int, page: Int?,
                        completion: @escaping (Result<[Video], Error>) -> Void)

    func getMovieCredits(for movieId: Int, page: Int?,
                         completion: @escaping (Result<MovieCredits, Error>) -> Void)

    func getMovieAccountState(for movieId: Int, completion: @escaping (Result<Movie.AccountState, Error>) -> Void)

    func rateMovie(movieId: Int, value: Double, completion: @escaping (Result<Void, Error>) -> Void)

}

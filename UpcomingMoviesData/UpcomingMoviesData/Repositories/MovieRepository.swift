//
//  MovieRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public class MovieRepository: MovieUseCaseProtocol {
    
    private var remoteDataSource: MovieRemoteDataSourceProtocol
    
    init(remoteDataSource: MovieRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getUpcomingMovies(page: page, completion: completion)
    }
    
    public func getPopularMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getPopularMovies(page: page, completion: completion)
    }
    
    public func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getTopRatedMovies(page: page, completion: completion)
    }
    
    public func getMoviesByGenre(page: Int, genreId: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getMoviesByGenre(page: page, genreId: genreId, completion: completion)
    }
    
    public func getSimilarMovies(page: Int, movieId: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getSimilarMovies(page: page, movieId: movieId, completion: completion)
    }
    
    public func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        remoteDataSource.getMovieDetail(with: movieId, completion: completion)
    }
    
    public func searchMovies(searchText: String, includeAdult: Bool, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.searchMovies(searchText: searchText,
                                      includeAdult: includeAdult,
                                      page: page,
                                      completion: completion)
    }
    
    public func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        remoteDataSource.getMovieReviews(for: movieId, page: page,
                                         completion: completion)
    }
    
    public func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[Video], Error>) -> Void) {
        remoteDataSource.getMovieVideos(for: movieId, page: page,
                                        completion: completion)
    }
    
    public func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        remoteDataSource.getMovieCredits(for: movieId, page: page,
                                         completion: completion)
    }
    
    public func isMovieInFavorites(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.isMovieInFavorites(for: movieId,
                                            completion: completion)
    }
    
    public func isMovieInWatchList(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.isMovieInWatchList(for: movieId,
                                            completion: completion)
    }

}

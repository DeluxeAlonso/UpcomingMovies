//
//  MovieRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public final class MovieRepository: MovieUseCaseProtocol {
    
    private var remoteDataSource: MovieRemoteDataSourceProtocol
    
    init(remoteDataSource: MovieRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getMovies(page: Int, movieListFilter: MovieListFilter, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.getMovies(page: page,
                                   movieListFilter: movieListFilter,
                                   completion: completion)
    }
    
    public func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        remoteDataSource.getMovieDetail(with: movieId, completion: completion)
    }
    
    public func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.searchMovies(searchText: searchText, page: page,
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
    
    public func isMovieInFavorites(for movieId: Int, and account: Account, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.isMovieInFavorites(for: movieId, and: account,
                                            completion: completion)
    }
    
    public func isMovieInWatchList(for movieId: Int, and account: Account, completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteDataSource.isMovieInWatchList(for: movieId, and: account,
                                            completion: completion)
    }

}

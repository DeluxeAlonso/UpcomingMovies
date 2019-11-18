//
//  MovieRemoteDataSourceProtocol.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

public protocol MovieRemoteDataSourceProtocol {
    
    func getMovies(page: Int,
                   movieListFilter: MovieListFilter,
                   completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getMovieDetail(with movieId: Int,
                        completion: @escaping (Result<Movie, Error>) -> Void)
    
    func searchMovies(searchText: String, page: Int?,
                      completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getMovieReviews(for movieId: Int, page: Int?,
                         completion: @escaping (Result<[Review], Error>) -> Void)
    
    func getMovieVideos(for movieId: Int, page: Int?,
                        completion: @escaping (Result<[Video], Error>) -> Void)
    
    func getMovieCredits(for movieId: Int, page: Int?,
                         completion: @escaping (Result<MovieCredits, Error>) -> Void)
    
    func isMovieInFavorites(for movieId: Int,
                            completion: @escaping (Result<Bool, Error>) -> Void)
    
    func isMovieInWatchList(for movieId: Int,
                            completion: @escaping (Result<Bool, Error>) -> Void)
    
}

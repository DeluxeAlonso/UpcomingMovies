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
    
    public func fetchMovies(page: Int, movieListFilter: MovieListFilter, completion: @escaping (Result<[Movie], Error>) -> Void) {
        remoteDataSource.fetchMovies(page: page,
                                     movieListFilter: movieListFilter,
                                     completion: completion)
    }
    
    public func fetchMovieDetail(with movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        remoteDataSource.fetchMovieDetail(with: movieId, completion: completion)
    }

}

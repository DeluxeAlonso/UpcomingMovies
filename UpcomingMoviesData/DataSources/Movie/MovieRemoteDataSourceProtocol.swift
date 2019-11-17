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
    
    func fetchMovies(page: Int,
                     movieListFilter: MovieListFilter,
                     completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func fetchMovieDetail(with movieId: Int,
                          completion: @escaping (Result<Movie, Error>) -> Void)
    
}

//
//  MovieUseCaseProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation

public protocol MovieUseCaseProtocol {
    
    func fetchMovies(page: Int,
                     movieListFilter: MovieListFilter,
                     completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func fetchMovieDetail(with movieId: Int,
                          completion: @escaping (Result<Movie, Error>) -> Void)
    
}

//
//  MovieRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import UpcomingMoviesData

final class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    
    private let client: MovieClient
    
    init(client: MovieClient) {
        self.client = client
    }
    
    func fetchMovies(page: Int, movieListFilter: MovieListFilter, completion: @escaping (Result<[Movie], Error>) -> Void) {
        client.getMovies(page: page, filter: movieListFilter, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                completion(.success(movieResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchMovieDetail(with movieId: Int,
                          completion: @escaping (Result<Movie, Error>) -> Void) {
        client.getMovieDetail(with: movieId, completion: { result in
            switch result {
            case .success(let movieDetailResult):
                let movie = movieDetailResult.asMovie()
                completion(.success(movie))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

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
    
    func getMovies(page: Int, movieListFilter: MovieListFilter, completion: @escaping (Result<[Movie], Error>) -> Void) {
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
    
    func getMovieDetail(with movieId: Int,
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
    
    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        client.searchMovies(searchText: searchText, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                completion(.success(movieResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[Review], Error>) -> Void) {
        client.getMovieReviews(page: page ?? 1, with: movieId, completion: { result in
            switch result {
            case .success(let reviewResult):
                guard let reviewResult = reviewResult else { return }
                completion(.success(reviewResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[Video], Error>) -> Void) {
        client.getMovieVideos(with: movieId, completion: { result in
            switch result {
            case .success(let videoResult):
                guard let videoResult = videoResult else { return }
                completion(.success(videoResult.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getMovieCredits(for movieId: Int, page: Int?, completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        client.getMovieCredits(with: movieId, completion: { result in
            switch result {
            case .success(let creditResult):
                guard let creditResult = creditResult else { return }
                let movieCredits = MovieCredits(cast: creditResult.cast,
                                                crew: creditResult.crew)
                completion(.success(movieCredits))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func isMovieInFavorites(for movieId: Int, and account: Account, completion: @escaping (Result<Bool, Error>) -> Void) {
        client.getMovieAccountState(with: movieId, sessionId: account.sessionId, completion: { result in
            switch result {
            case .success(let movieAccountStateResult):
                guard let movieAccountStateResult = movieAccountStateResult else { return }
                completion(.success(movieAccountStateResult.favorite))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func isMovieInWatchList(for movieId: Int, and account: Account, completion: @escaping (Result<Bool, Error>) -> Void) {
        client.getMovieAccountState(with: movieId, sessionId: account.sessionId, completion: { result in
            switch result {
            case .success(let movieAccountStateResult):
                guard let movieAccountStateResult = movieAccountStateResult else { return }
                completion(.success(movieAccountStateResult.watchlist))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

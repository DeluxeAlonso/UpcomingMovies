//
//  MovieRemoteDataSource.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 11/10/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import UpcomingMoviesData

final class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {

    private let client: MovieClientProtocol
    private let authManager: AuthenticationManager

    init(client: MovieClientProtocol, authManager: AuthenticationManager = AuthenticationManager.shared) {
        self.client = client
        self.authManager = authManager
    }

    func getUpcomingMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        client.getUpcomingMovies(page: page, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getPopularMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        client.getPopularMovies(page: page, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getTopRatedMovies(page: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        client.getTopRatedMovies(page: page, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getSimilarMovies(page: Int, movieId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        client.getSimilarMovies(page: page, movieId: movieId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMoviesByGenre(page: Int, genreId: Int, completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        client.getMoviesByGenre(page: page, genreId: genreId, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMovieDetail(with movieId: Int,
                        completion: @escaping (Result<UpcomingMoviesDomain.Movie, Error>) -> Void) {
        client.getMovieDetail(with: movieId, completion: { result in
            switch result {
            case .success(let movieDetailResult):
                let movie = movieDetailResult.asMovie().asDomain()
                completion(.success(movie))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func searchMovies(searchText: String,
                      includeAdult: Bool,
                      page: Int?,
                      completion: @escaping (Result<[UpcomingMoviesDomain.Movie], Error>) -> Void) {
        client.searchMovies(searchText: searchText, includeAdult: includeAdult, completion: { result in
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                let movies = movieResult.results.map { $0.asDomain() }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMovieReviews(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Review], Error>) -> Void) {
        client.getMovieReviews(page: page ?? 1, with: movieId, completion: { result in
            switch result {
            case .success(let reviewResult):
                guard let reviewResult = reviewResult else { return }
                let reviews = reviewResult.results.map { $0.asDomain() }
                completion(.success(reviews))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMovieVideos(for movieId: Int, page: Int?, completion: @escaping (Result<[UpcomingMoviesDomain.Video], Error>) -> Void) {
        client.getMovieVideos(with: movieId, completion: { result in
            switch result {
            case .success(let videoResult):
                guard let videoResult = videoResult else { return }
                let videos = videoResult.results.map { $0.asDomain() }
                completion(.success(videos))
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
                let cast = creditResult.cast.map { $0.asDomain() }
                let crew = creditResult.crew.map { $0.asDomain() }
                let movieCredits = MovieCredits(cast: cast, crew: crew)
                completion(.success(movieCredits))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMovieAccountState(for movieId: Int,
                              completion: @escaping (Result<UpcomingMoviesDomain.Movie.AccountState, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.getMovieAccountState(with: movieId, sessionId: account.sessionId, completion: { result in
            switch result {
            case .success(let movieAccountStateResult):
                guard let movieAccountStateResult = movieAccountStateResult else { return }
                let favorite = movieAccountStateResult.favorite
                let watchlist = movieAccountStateResult.watchlist
                completion(.success(.init(favorite: favorite, watchlist: watchlist)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func rateMovie(movieId: Int, value: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let account = authManager.userAccount else { return }
        client.rateMovie(movieId: movieId, sessionId: account.sessionId, value: value) { result in
            switch result {
            case .success:
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

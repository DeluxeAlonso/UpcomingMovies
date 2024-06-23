//
//  MovieDetailInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class MovieDetailInteractor: MovieDetailInteractorProtocol {

    private let movieUseCase: MovieUseCaseProtocol
    private let movieVisitUseCase: MovieVisitUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol

    private let authHandler: AuthenticationHandlerProtocol

    init(movieUseCase: MovieUseCaseProtocol,
         movieVisitUseCase: MovieVisitUseCaseProtocol,
         genreUseCase: GenreUseCaseProtocol,
         accountUseCase: AccountUseCaseProtocol,
         authHandler: AuthenticationHandlerProtocol) {
        self.movieUseCase = movieUseCase
        self.movieVisitUseCase = movieVisitUseCase
        self.genreUseCase = genreUseCase
        self.accountUseCase = accountUseCase
        self.authHandler = authHandler
    }

    func isUserSignedIn() -> Bool {
        authHandler.isUserSignedIn()
    }

    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        genreUseCase.find(with: id, completion: completion)
    }

    func findGenres(for identifiers: [Int], completion: @escaping (Result<[Genre], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var genres: [Genre] = []

        for id in identifiers {
            dispatchGroup.enter()
            findGenre(with: id) { result in
                if let genre = try? result.get() { genres.append(genre) }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
            completion(.success(genres))
        }
    }

    func getMovieDetail(for movieId: Int, completion: @escaping (Result<MovieProtocol, Error>) -> Void) {
        movieUseCase.getMovieDetail(for: movieId, completion: { result in
            switch result {
            case .success(let movie):
                completion(.success(MovieModel(movie)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMovieAccountState(for movieId: Int,
                              completion: @escaping (Result<Movie.AccountState, Error>) -> Void) {
        movieUseCase.getMovieAccountState(for: movieId, completion: completion)
    }

    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        accountUseCase.markMovieAsFavorite(movieId: movieId, favorite: favorite, completion: completion)
    }

    func addToWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        accountUseCase.addToWatchlist(movieId: movieId, watchlist: true, completion: completion)
    }

    func removeFromWatchlist(movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        accountUseCase.addToWatchlist(movieId: movieId, watchlist: false, completion: completion)
    }

    func saveMovieVisit(with id: Int, title: String, posterPath: String?) {
        movieVisitUseCase.save(with: id, title: title, posterPath: posterPath, completion: { _ in })
    }

}

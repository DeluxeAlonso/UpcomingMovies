//
//  MovieDetailInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

class MovieDetailInteractor: MovieDetailInteractorProtocol {

    private let movieUseCase: MovieUseCaseProtocol
    private let movieVisitUseCase: MovieVisitUseCaseProtocol
    private let genreUseCase: GenreUseCaseProtocol
    private let accountUseCase: AccountUseCaseProtocol

    private let authHandler: AuthenticationHandlerProtocol

    init(useCaseProvider: UseCaseProviderProtocol, authHandler: AuthenticationHandlerProtocol) {
        self.movieUseCase = useCaseProvider.movieUseCase()
        self.movieVisitUseCase = useCaseProvider.movieVisitUseCase()
        self.genreUseCase = useCaseProvider.genreUseCase()
        self.accountUseCase = useCaseProvider.accountUseCase()
        self.authHandler = authHandler
    }

    func isUserSignedIn() -> Bool {
        return authHandler.isUserSignedIn()
    }

    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        genreUseCase.find(with: id, completion: completion)
    }

    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        movieUseCase.getMovieDetail(for: movieId, completion: completion)
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

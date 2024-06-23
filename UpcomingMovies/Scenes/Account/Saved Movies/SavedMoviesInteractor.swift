//
//  SavedMoviesInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/23/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

final class FavoritesSavedMoviesInteractor: SavedMoviesInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getSavedMovies(page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        accountUseCase.getFavoriteList(page: page, sortBy: .createdAtDesc, completion: { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

final class WatchlistSavedMoviesInteractor: SavedMoviesInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getSavedMovies(page: Int?, completion: @escaping (Result<[MovieProtocol], Error>) -> Void) {
        accountUseCase.getWatchlist(page: page, sortBy: .createdAtDesc, completion: { result in
            switch result {
            case .success(let movies):
                completion(.success(movies.map(MovieModel.init)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

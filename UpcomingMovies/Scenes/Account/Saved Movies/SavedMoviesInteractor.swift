//
//  SavedMoviesInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/23/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class FavoritesSavedMoviesInteractor: SavedMoviesInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getSavedMovies(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        accountUseCase.getFavoriteList(page: page, sortBy: .createdAtDesc, completion: completion)
    }

}

final class WatchlistSavedMoviesInteractor: SavedMoviesInteractorProtocol {

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func getSavedMovies(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        accountUseCase.getWatchlist(page: page, sortBy: .createdAtDesc, completion: completion)
    }

}

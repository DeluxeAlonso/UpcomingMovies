//
//  SavedMoviesInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/23/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class SavedMoviesInteractor: SavedMoviesInteractorProtocol {
    
    private let accountUseCase: AccountUseCaseProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.accountUseCase = useCaseProvider.accountUseCase()
    }
    
    func getFavoriteList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        accountUseCase.getFavoriteList(page: page, completion: completion)
    }
    
    func getWatchList(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        accountUseCase.getWatchList(page: page, completion: completion)
    }
    
}

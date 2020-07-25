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
    
    private let collectionOption: ProfileCollectionOption
    private let accountUseCase: AccountUseCaseProtocol
    
    init(collectionOption: ProfileCollectionOption, useCaseProvider: UseCaseProviderProtocol) {
        self.collectionOption = collectionOption
        self.accountUseCase = useCaseProvider.accountUseCase()
    }
    
    var displayTitle: String? {
        return collectionOption.title
    }
    
    func getSavedMovies(page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        switch collectionOption {
        case .favorites:
            accountUseCase.getFavoriteList(page: page, completion: completion)
        case .watchlist:
            accountUseCase.getWatchList(page: page, completion: completion)
        }
    }
    
}

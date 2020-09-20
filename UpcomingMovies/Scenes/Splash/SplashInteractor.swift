//
//  SplashInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/3/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

struct SplashInteractor: SplashInteractorProtocol {
    
    private let genreUseCase: GenreUseCaseProtocol
    private let configurationHandler: ConfigurationHandlerProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol, configurationHandler: ConfigurationHandlerProtocol) {
        self.genreUseCase = useCaseProvider.genreUseCase()
        self.configurationHandler = configurationHandler
    }
    
    func getAppConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void) {
        configurationHandler.getAppConfiguration(completion: completion)
    }
    
    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        genreUseCase.fetchAll(completion: completion)
    }
    
}

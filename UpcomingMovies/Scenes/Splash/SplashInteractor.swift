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
    private let configurationUseCase: ConfigurationUseCaseProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.genreUseCase = useCaseProvider.genreUseCase()
        self.configurationUseCase = useCaseProvider.configurationUseCase()
    }
    
    func getAppConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void) {
        configurationUseCase.getConfiguration(completion: completion)
    }
    
    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        genreUseCase.fetchAll(completion: completion)
    }
    
}

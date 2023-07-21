//
//  SplashInteractor.swift
//  UpcomingMovies
//
//  Created by Alonso on 8/3/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

struct SplashInteractor: SplashInteractorProtocol {

    private let genreUseCase: GenreUseCaseProtocol
    private let configurationUseCase: ConfigurationUseCaseProtocol

    init(genreUseCase: GenreUseCaseProtocol,
         configurationUseCase: ConfigurationUseCaseProtocol) {
        self.genreUseCase = genreUseCase
        self.configurationUseCase = configurationUseCase
    }

    // MARK: - SplashInteractorProtocol

    func getAppConfiguration(completion: @escaping (Result<Configuration, Error>) -> Void) {
        configurationUseCase.getConfiguration(completion: completion)
    }

    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        genreUseCase.fetchAll(completion: completion, forceRefresh: false)
    }

}

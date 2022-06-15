//
//  UseCaseProviderProtocol.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 10/26/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

public protocol UseCaseProviderProtocol {

    func movieUseCase() -> MovieUseCaseProtocol
    func genreUseCase() -> GenreUseCaseProtocol
    func movieVisitUseCase() -> MovieVisitUseCaseProtocol
    func movieSearchUseCase() -> MovieSearchUseCaseProtocol
    func userUseCase() -> UserUseCaseProtocol
    func accountUseCase() -> AccountUseCaseProtocol
    func authUseCase() -> AuthUseCaseProtocol
    func configurationUseCase() -> ConfigurationUseCaseProtocol

}

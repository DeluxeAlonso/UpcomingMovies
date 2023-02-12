//
//  UpcomingMoviesAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class UpcomingMoviesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MoviesInteractorProtocol.self, name: "UpcomingMovies") { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return UpcomingMoviesInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(UpcomingMoviesFactoryProtocol.self) { resolver in
            guard let userPreferencesHandler = resolver.resolve(UserPreferencesHandlerProtocol.self) else {
                fatalError("UserPreferencesHandlerProtocol dependency could not be resolved")
            }
            return UpcomingMoviesFactory(userPreferencesHandler: userPreferencesHandler)
        }

        container.register(UpcomingMoviesViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "UpcomingMovies") else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }
            guard let factory = resolver.resolve(UpcomingMoviesFactoryProtocol.self) else {
                fatalError("UpcomingMoviesFactoryProtocol dependency could not be resolved")
            }
            return UpcomingMoviesViewModel(interactor: interactor, factory: factory)
        }
    }

}

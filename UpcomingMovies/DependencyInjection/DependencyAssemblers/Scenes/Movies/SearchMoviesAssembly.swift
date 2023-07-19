//
//  SearchMoviesAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class SearchMoviesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SearchOptionsInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return SearchOptionsInteractor(movieVisitUseCase: useCaseProvider.movieVisitUseCase(),
                                           genreUseCase: useCaseProvider.genreUseCase())
        }
        container.register(SearchOptionsViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(SearchOptionsInteractorProtocol.self) else {
                fatalError("SearchOptionsInteractorProtocol dependency could not be resolved")
            }
            return SearchOptionsViewModel(interactor: interactor)
        }

        container.register(SearchMoviesResultInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            guard let authHandler = resolver.resolve(AuthenticationHandlerProtocol.self) else {
                fatalError("AuthenticationHandlerProtocol dependency could not be resolved")
            }
            return SearchMoviesResultInteractor(useCaseProvider: useCaseProvider,
                                                authHandler: authHandler)
        }
        container.register(SearchMoviesResultViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(SearchMoviesResultInteractorProtocol.self) else {
                fatalError("SearchMoviesResultInteractorProtocol dependency could not be resolved")
            }
            return SearchMoviesResultViewModel(interactor: interactor)
        }
    }

}

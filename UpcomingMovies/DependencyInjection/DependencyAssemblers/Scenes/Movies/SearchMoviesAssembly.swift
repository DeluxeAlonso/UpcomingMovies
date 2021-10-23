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
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return SearchOptionsInteractor(useCaseProvider: useCaseProvider!)
        }
        container.register(SearchOptionsViewModelProtocol.self) { resolver in
            let interactor = resolver.resolve(SearchOptionsInteractorProtocol.self)
            return SearchOptionsViewModel(interactor: interactor!)
        }

        container.register(SearchMoviesResultInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            let authHandler = resolver.resolve(AuthenticationHandlerProtocol.self)

            return SearchMoviesResultInteractor(useCaseProvider: useCaseProvider!,
                                                authHandler: authHandler!)
        }
        container.register(SearchMoviesResultViewModelProtocol.self) { resolver in
            let interactor = resolver.resolve(SearchMoviesResultInteractorProtocol.self)
            return SearchMoviesResultViewModel(interactor: interactor!)
        }
    }

}

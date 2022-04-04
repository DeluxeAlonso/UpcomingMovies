//
//  MovieDetailAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Swinject
import UpcomingMoviesDomain

final class MovieDetailAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MovieDetailFactoryProtocol.self) { _ in
            MovieDetailFactory()
        }

        // MovieDetailViewModelProtocol register

        container.register(MovieDetailInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            guard let authHandler = resolver.resolve(AuthenticationHandlerProtocol.self) else {
                fatalError("AuthenticationHandlerProtocol dependency could not be resolved")
            }
            return MovieDetailInteractor(useCaseProvider: useCaseProvider,
                                         authHandler: authHandler)
        }

        container.register(MovieDetailViewModelProtocol.self) { (resolver, movie: Movie) in
            guard let factory = resolver.resolve(MovieDetailFactoryProtocol.self) else {
                fatalError("MovieDetailFactoryProtocol dependency could not be resolved")
            }
            guard let interactor = resolver.resolve(MovieDetailInteractorProtocol.self) else {
                fatalError("MovieDetailInteractorProtocol dependency could not be resolved")
            }
            return MovieDetailViewModel(movie, interactor: interactor, factory: factory)
        }

        container.register(MovieDetailViewModelProtocol.self) { (resolver, movieId: Int, movieTitle: String) in
            guard let factory = resolver.resolve(MovieDetailFactoryProtocol.self) else {
                fatalError("MovieDetailFactoryProtocol dependency could not be resolved")
            }
            guard let interactor = resolver.resolve(MovieDetailInteractorProtocol.self) else {
                fatalError("MovieDetailInteractorProtocol dependency could not be resolved")
            }
            return MovieDetailViewModel(id: movieId, title: movieTitle,
                                        interactor: interactor,
                                        factory: factory)
        }

        // MovieDetailUIHelperProtocol register

        container.register(MovieDetailUIHelperProtocol.self) { resolver in
            guard let progressHUDAdapter = resolver.resolve(ProgressHUDAdapterProtocol.self) else {
                fatalError("ProgressHUDAdapterProtocol dependency could not be resolved")
            }
            return MovieDetailUIHelper(progressHUDAdapter: progressHUDAdapter)
        }
    }

}

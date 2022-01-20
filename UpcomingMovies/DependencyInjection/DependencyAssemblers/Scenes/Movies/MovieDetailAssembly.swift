//
//  MovieDetailAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/16/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class MovieDetailAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MovieDetailFactoryProtocol.self) { _ in
            MovieDetailFactory()
        }

        // MovieDetailViewModelProtocol register

        container.register(MovieDetailInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            let authHandler = resolver.resolve(AuthenticationHandlerProtocol.self)

            return MovieDetailInteractor(useCaseProvider: useCaseProvider!,
                                         authHandler: authHandler!)
        }

        container.register(MovieDetailViewModelProtocol.self) { (resolver, movie: Movie) in
            let factory = resolver.resolve(MovieDetailFactoryProtocol.self)
            let interactor = resolver.resolve(MovieDetailInteractorProtocol.self)

            return MovieDetailViewModel(movie, interactor: interactor!, factory: factory!)
        }

        container.register(MovieDetailViewModelProtocol.self) { (resolver, movieId: Int, movieTitle: String) in
            let factory = resolver.resolve(MovieDetailFactoryProtocol.self)
            let interactor = resolver.resolve(MovieDetailInteractorProtocol.self)

            return MovieDetailViewModel(id: movieId, title: movieTitle,
                                        interactor: interactor!,
                                        factory: factory!)
        }

        // MovieDetailUIHelperProtocol register

        container.register(MovieDetailUIHelperProtocol.self) { resolver in
            let progressHUDAdapter = resolver.resolve(ProgressHUDAdapterProtocol.self)
            return MovieDetailUIHelper(progressHUDAdapter: progressHUDAdapter!)
        }
    }

}

//
//  MovieCreditsAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/17/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class MovieCreditsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MovieCreditsFactoryProtocol.self) { _ in
            MovieCreditsFactory()
        }

        container.register(MovieCreditsInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return MovieCreditsInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(MovieCreditsViewModelProtocol.self) { (resolver, movieId: Int, movieTitle: String) in
            guard let factory = resolver.resolve(MovieCreditsFactoryProtocol.self) else {
                fatalError("MovieCreditsFactoryProtocol dependency could not be resolved")
            }
            guard let interactor = resolver.resolve(MovieCreditsInteractorProtocol.self) else {
                fatalError("MovieCreditsInteractorProtocol dependency could not be resolved")
            }
            return MovieCreditsViewModel(movieId: movieId, movieTitle: movieTitle,
                                         interactor: interactor, factory: factory)
        }
    }

}

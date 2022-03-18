//
//  UpcomingMoviesAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/15/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
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

        container.register(UpcomingMoviesViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(MoviesInteractorProtocol.self, name: "UpcomingMovies") else {
                fatalError("MoviesInteractorProtocol dependency could not be resolved")
            }
            return UpcomingMoviesViewModel(interactor: interactor)
        }
    }

}

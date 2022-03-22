//
//  SplashAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/18/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import Swinject
import UpcomingMoviesDomain

final class SplashAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SplashInteractorProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return SplashInteractor(useCaseProvider: useCaseProvider)
        }

        container.register(SplashViewModelProtocol.self) { resolver in
            guard let interactor = resolver.resolve(SplashInteractorProtocol.self) else {
                fatalError("SplashInteractorProtocol dependency could not be resolved")
            }
            guard let genreHandler = resolver.resolve(GenreHandlerProtocol.self) else {
                fatalError("GenreHandlerProtocol dependency could not be resolved")
            }
            guard let configurationHandler = resolver.resolve(ConfigurationHandlerProtocol.self) else {
                fatalError("ConfigurationHandlerProtocol dependency could not be resolved")
            }
            return SplashViewModel(interactor: interactor,
                                   genreHandler: genreHandler,
                                   configurationHandler: configurationHandler)
        }
    }

}

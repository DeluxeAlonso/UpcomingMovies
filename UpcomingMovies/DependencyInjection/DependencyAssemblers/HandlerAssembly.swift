//
//  HandlerAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UpcomingMoviesDomain
import Swinject

final class HandlerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AuthenticationHandlerProtocol.self) { resolver in
            guard let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return AuthenticationHandler(authUseCase: useCaseProvider.authUseCase(),
                                         userUseCase: useCaseProvider.userUseCase())
        }.inObjectScope(.container)

        container.register(DeepLinkHandlerProtocol.self) { _ in
            DeepLinkHandler()
        }.inObjectScope(.container)

        container.register(NavigationHandlerProtocol.self) { resolver in
            guard let deepLinkHandler = resolver.resolve(DeepLinkHandlerProtocol.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return NavigationHandler(deepLinkHandler: deepLinkHandler)
        }.inObjectScope(.container)

        container.register(GenreHandlerProtocol.self) { _ in
            GenreHandler()
        }.inObjectScope(.container)

        container.register(ConfigurationHandlerProtocol.self) { _ in
            ConfigurationHandler()
        }.inObjectScope(.container)

        container.register(UserPreferencesHandlerProtocol.self) { _ in
            UserPreferencesHandler()
        }.inObjectScope(.container)
    }

}

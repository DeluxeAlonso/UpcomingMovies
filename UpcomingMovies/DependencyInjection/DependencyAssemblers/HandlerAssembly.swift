//
//  HandlerAssembly.swift
//  UpcomingMovies
//
//  Created by Alonso on 9/13/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain
import Swinject

final class HandlerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthenticationHandlerProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return AuthenticationHandler(authUseCase: useCaseProvider!.authUseCase(),
                                         userUseCase: useCaseProvider!.userUseCase())
        }.inObjectScope(.container)
        
        container.register(NavigationHandlerProtocol.self) { _ in
            NavigationHandler()
        }.inObjectScope(.container)
        
        container.register(GenreHandlerProtocol.self) { _ in
            GenreHandler()
        }.inObjectScope(.container)
        
        container.register(ConfigurationHandlerProtocol.self) { _ in
            ConfigurationHandler()
        }.inObjectScope(.container)

        container.register(ViewStateHandlerProtocol.self) { _  in
            ViewStateHandler()
        }.inObjectScope(.container)
    }
    
}

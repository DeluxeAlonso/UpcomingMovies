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

class SplashAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SplashInteractorProtocol.self) { resolver in
            let useCaseProvider = resolver.resolve(UseCaseProviderProtocol.self)
            return SplashInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(SplashViewModelProtocol.self) { resolver in
            let interactor = resolver.resolve(SplashInteractorProtocol.self)
            let genreHandler = resolver.resolve(GenreHandlerProtocol.self)
            let configurationHandler = resolver.resolve(ConfigurationHandlerProtocol.self)
            
            return SplashViewModel(interactor: interactor!,
                                   genreHandler: genreHandler!,
                                   configurationHandler: configurationHandler!)
        }
    }
    
}
